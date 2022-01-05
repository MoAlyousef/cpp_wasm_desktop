#include "cocoa_helper.h"
#import <Cocoa/Cocoa.h>

void add_nsmenu(void) {
    id menubar = [[NSMenu alloc] initWithTitle:@""];
    id editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
    id editMenuItem = [NSMenuItem alloc];
    [editMenuItem setSubmenu:editMenu];
    [menubar addItem:editMenuItem];

    id item = [[NSMenuItem alloc] initWithTitle:@""
                                            action:@selector(hide:)
                                    keyEquivalent:@"h"];

    id appMenu = [NSMenu alloc];
    [appMenu addItem:item];

    item = [[NSMenuItem alloc] initWithTitle:@"Cut"
                                        action:@selector(cut:)
                                keyEquivalent:@"x"];
    [editMenu addItem:item];

    item = [[NSMenuItem alloc] initWithTitle:@"Copy"
                                        action:@selector(copy:)
                                keyEquivalent:@"c"];
    [editMenu addItem:item];

    item = [[NSMenuItem alloc] initWithTitle:@"Paste"
                                        action:@selector(paste:)
                                keyEquivalent:@"v"];
    [editMenu addItem:item];

    item = [[NSMenuItem alloc] initWithTitle:@"Select All"
                                        action:@selector(selectAll:)
                                keyEquivalent:@"a"];
    [editMenu addItem:item];
    [menubar autorelease];

    [[NSApplication sharedApplication] setMainMenu:menubar];
}
