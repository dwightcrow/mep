Ext.setup({
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    icon: 'icon.png',
    glossOnIcon: false,

    onReady: function() {

        var addHandler = function(button, event) {
             Ext.getCmp('main_panel').update("add button pressed");
        };
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
        }];

      	new Ext.Panel({
            id: 'main_panel',
            fullscreen: true,
            html: document.getElementById("content").innerHTML,
            styleHtmlContent: true,
            bodyStyle: 'padding: 0px',
            dockedItems: dockedItems
        });
    }
});
