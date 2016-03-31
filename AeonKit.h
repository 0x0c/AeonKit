#pragma once

#include <StandardCplusplus.h>
#include <string>
#include <Arduino.h>

namespace AeonKit
{
	class Module
	{
	public:
		Module();
		~Module();
		std::string module_name;

		void analogReset() {
			#if defined(ADMUX)
			#if defined(ADCSRB) && defined(MUX5)
			ADCSRB |= (1 << MUX5);
			#endif
			ADMUX = 0x1F;
			ADCSRA |= (1 << ADSC);
			loop_until_bit_is_clear(ADCSRA, ADSC);
			#endif
		}

	};

	class TouchSensor : public Module
	{
	public:
		const int fslpSenseLine = A0;
		const int fslpDriveLine1 = 11;
		const int fslpDriveLine2 = A1;
		const int fslpBotR0 = 10;
		TouchSensor() {
			this->module_name = "TouchSensor";
			pinMode(2, OUTPUT);
		};
		~TouchSensor() {};
		int position() {
			pinMode(fslpSenseLine, OUTPUT);
			digitalWrite(fslpSenseLine, LOW);
			pinMode(fslpDriveLine1, OUTPUT);
			digitalWrite(fslpDriveLine1, LOW);
			pinMode(fslpDriveLine2, OUTPUT);
			digitalWrite(fslpDriveLine2, LOW);
			pinMode(fslpBotR0, OUTPUT);
			digitalWrite(fslpBotR0, LOW);
			digitalWrite(fslpDriveLine1, HIGH);
			pinMode(fslpBotR0, INPUT);
			pinMode(fslpSenseLine, INPUT);
			delayMicroseconds(10);
			analogReset();

  			return analogRead(fslpSenseLine);
		}

		int pressure() {
			pinMode(fslpDriveLine1, OUTPUT);
			digitalWrite(fslpDriveLine1, HIGH);
			pinMode(fslpBotR0, OUTPUT);
			digitalWrite(fslpBotR0, LOW);
			pinMode(fslpSenseLine, INPUT);
			pinMode(fslpDriveLine2, INPUT);
			delayMicroseconds(10);
			analogReset();
			int v1 = analogRead(fslpDriveLine2);
			analogReset();
			int v2 = analogRead(fslpSenseLine);
			if (v1 == v2) {
				return 32 * 1023;
			}
			return 32 * v2 / (v1 - v2);
		}
	};

	class TiltSensor : public Module
	{
	public:
		TiltSensor() {
			this->module_name = "TiltSensor";
		};
		~TiltSensor();
	};

	class DepthSensor : public Module
	{
	public:
		DepthSensor() {
			this->module_name = "DepthSensor";
		}
		~DepthSensor();
		int depth();
	};
};
