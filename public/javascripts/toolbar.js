Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,

    onReady: function() {

        var tapHandler = function(button, event) {
            var txt = "User tapped the '" + button.text + "' button.";
            Ext.getCmp('toolbartxt').update(txt);
        };


        var buttonsGroup1 = [];
       /* var buttonsGroup1 = [{
            text: 'Back',
            ui: 'back',
            handler: tapHandler
        }, {
            text: 'Default',
            handler: tapHandler
        }, {
            text: 'Round',
            ui: 'round',
            handler: tapHandler
        }];*/

     /*   var buttonsGroup2 = [{
            xtype: 'segmentedbutton',
            items: [{
                text: 'Option 1',
                handler: tapHandler
            }, {
                text: 'Option 2',
                pressed : true,
                handler: tapHandler
            }, {
                text: 'Option 3',
                handler: tapHandler
            }]
        }];*/

        var toolbar_icons = {
            xtype: 'toolbar',
            dock: 'top',
            scroll: 'horizontal',
            items: [
                { iconMask: true, iconCls: 'action' },
            ]
        }


        if (!Ext.is.Phone) {
           // buttonsGroup1.push({xtype: 'spacer'});
           // buttonsGroup2.push({xtype: 'spacer'});

            var dockedItems = [{
                xtype: 'toolbar',
                // dock this toolbar at the top
                dock: 'top',
                items: buttonsGroup1
            }];
            new Ext.Panel({
                id: 'toolbartxt',
                fullscreen: true,
                // styleHtmlContent: true,
                dockedItems: dockedItems,
                defaults: {
                    scroll: 'vertical',
                    xtype: 'panel',
                    layout: 'hbox',
                    pack: 'justify',
                    align: 'center',
                    defaults: {
                        xtype: 'button',
                        ui: 'confirm'
                    }
                }
            });
        // Phone has far less screen real-estate
        } else {
            var dockedItems = [{
                xtype: 'toolbar',
                ui: 'light',
                title: 'Hooqup',
                dock: 'top',
            }];/*, {
                xtype: 'toolbar',
                ui: 'dark',
                items: buttonsGroup2,
                dock: 'top'
            }, {
                xtype: 'toolbar',
                ui: 'dark',
                items: buttonsGroup3,
                dock: 'top'
            }, {
                xtype: 'toolbar',
                ui: 'light',
                items: buttonsGroup4,
                dock: 'bottom'
            }];*/
        }

        new Ext.Panel({
            id: 'phone_screen',
            fullscreen: true,
            html: document.getElementById("content").innerHTML,
            styleHtmlContent: true,
            dockedItems: dockedItems
        });
    }
});
