#include <StandardCplusplus.h>
#include <system_configuration.h>
#include <unwind-cxx.h>
#include <utility.h>
#include <string>
#include <vector>
#include <iterator>
#include "U8glib.h"
#include <AeonUI.h>

using namespace AeonUI;

U8GLIB_SSD1306_128X32 u8g(U8G_I2C_OPT_NONE);

const uint8_t tool_icon_image[] U8G_PROGMEM = {
  0x00, 0x00, 0x0E, 0x00, 0x00, 0x80, 0x0F, 0x00, 0x04, 0xC0, 0x0F, 0x00, 
  0x0E, 0xE0, 0x07, 0x00, 0x1F, 0xE0, 0x03, 0x00, 0x3F, 0xF0, 0x03, 0x00, 
  0x3E, 0xF0, 0x03, 0x00, 0x7C, 0xF0, 0x03, 0x00, 0xF0, 0xF0, 0x03, 0x0E, 
  0xE0, 0xF1, 0x07, 0x0F, 0xC0, 0xF3, 0xFF, 0x0F, 0x80, 0xFF, 0xFF, 0x07, 
  0x00, 0xFF, 0xFF, 0x07, 0x00, 0xFE, 0xFF, 0x03, 0x00, 0xFF, 0xFF, 0x01, 
  0x80, 0xFF, 0x7F, 0x00, 0xC0, 0xFF, 0x01, 0x00, 0xE0, 0xFF, 0x01, 0x00, 
  0xF0, 0xFF, 0x03, 0x00, 0xF8, 0xBF, 0x0F, 0x00, 0xFC, 0x1F, 0x3F, 0x00, 
  0xFE, 0x0F, 0x7F, 0x00, 0xCF, 0x07, 0xFF, 0x00, 0xC7, 0x03, 0xFE, 0x01, 
  0xE7, 0x01, 0xFE, 0x01, 0xFF, 0x00, 0xFC, 0x01, 0x7E, 0x00, 0xF8, 0x01, 
  0x3C, 0x00, 0xE0, 0x00
};

Page page;

void buttonSelected(EventType type, Control *c)
{
	Serial.println("1");
}

void switchValueChanged(EventType type, Control *c)
{
	Serial.println("2");
}

void draw()
{
	page.draw();
}

void setup(void)
{
	// flip screen, if required
	// u8g.setRot90();
	// u8g.setRot180();
	u8g.setFont(u8g_font_6x10);
	u8g.setFontPosTop();
	u8g.setCursorFont(u8g_font_cursor);
	Serial.begin(9600);
	pinMode(6, INPUT);
	pinMode(7, INPUT);

	// set REST HIGH
	pinMode(13, OUTPUT);
	digitalWrite(13, HIGH);
	
	page.context = &u8g;

	// List *list = new List();
	// page.listner.add(new Event(list, EventTypeKeyLeft, NULL));
	// page.listner.add(new Event(list, EventTypeKeyRight, NULL));
	// page.add(list);

	Button *c = new Button(Point(0, 0), Point(30, 30));
	page.listner.add(new Event(c, EventTypeKeySelect, buttonSelected));
	c->identifier = 1;
	c->roundRect = true;
	c->text = "btn1";
	// list->add(c);
	page.add(c);

	Button *c2 = new Button(Point(31, 0), Point(30, 30));
	page.listner.add(new Event(c2, EventTypeKeySelect, buttonSelected));
	c2->identifier = 2;
	c2->text = "btn2";
	// list->add(c2);
	page.add(c2);

	// // Switch *s = new Switch(Point(21, 0), Point(15, 15));
	// Switch *s = new Switch(Point(21, 0), Point(30, 30));
	// page.listner.add(new Event(s, EventTypeKeySelect, switchValueChanged));
	// s->roundRect = true;
	// s->identifier = 3;
	// list->add(s);

	// Image *i = new Image(Point(5, 5), Point(28, 28));
	// i->image = (uint8_t*)tool_icon_image;
	// list->add(i);

	// Label *l = new Label(Point(3, 30), "Hello");
	// page.add(l);
}

void loop(void)
{
	if (page.needToRefresh()) {
		u8g.firstPage();
		do {
			u8g.drawLine(0, 0, 128, 31);
			draw();
		} while(u8g.nextPage());
	}
}
