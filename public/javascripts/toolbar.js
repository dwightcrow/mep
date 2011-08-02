Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,

    onReady: function() {

        var addHandler = function(button, event) {
             Ext.getCmp('main_panel').update("add button pressed");
        };

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


            var dockedItems = [{
                xtype: 'toolbar',
                ui: 'light',
                title: 'Hooqup',
                dock: 'top',
                //+ button
                items:[{xtype: 'spacer'},
                {
                	iconMask: true, 
                	iconAlign: 'right', 
                	ui: 'plain', 
                	handler: addHandler,
                	iconCls: 'add'
                }]
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

        eventPanel = new Ext.Panel({
            id: 'main_panel',
            fullscreen: true,
            html: document.getElementById("content").innerHTML,
            styleHtmlContent: true,
            bodyStyle: 'padding: 0px',
            dockedItems: dockedItems
        });
    }
});
