var rootPanel;
var eventPanelList = [];

console.log(data);
// get data
var dataHolder;
console.log( 'calling getJSON');
$.get( '/events/get_events', function(data){
dataHolder = data;
console.log( data );
renderEvents( data );
}
);
console.log( 'after calling eventJSON');
/*
Guide to below frankencode
1. var data comes from dummy.js right now. Will come from something else later
2. RenderEvents( data ) appends htmlized events into EventPanelList
3. Two toolbars are docked to top and bottom below in DockedItems
4. We feed the EventPanelList and DockedItems into eventFlowPanel
4. We make an app with a "cards" main view - 3 cards are eventFlowPanel, newEventPanel
   and detailsPanel
5. Buttons and taps transition between the active cards
*/

// We'll have this from authentication; probly not with this exact var name.
var CURRENT_USER_ID = 1;

// How many participant pics show up in each event?
var NUM_VISIBLE_PARTICIPANTS = 3;

var activityIcons = {
  1: '/images/activity.jpg',
  2: '/images/activity.jpg',
  3: '/images/activity.jpg'
};

/* Returns the 2-letter weekday abbreviation for the weekday of a given date. */
var weekdayAbbreviations = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
var dateToWeekdayAbbreviation = function(date) {
  return weekdayAbbreviations[date.getDay()];
};

/* Returns the 12-hour hour time for a given date. */
var dateToHour = function(date) {
  // TODO: implement.
  return date.getHours() % 12 + 1;
};

/* Returns whether the given date is AM or PM. */
var dateToAmPm = function(date) {
  var hours = date.getHours();
  if (hours < 12) return 'AM';
  else return 'PM';
};

/* Renders DOM elements for all the events. */
var renderEvents = function(eventList) {

  var renderEvent = function(eventItem) {
    var createdByMe = eventItem.creatorId === CURRENT_USER_ID;
    var typeName = typeNames[eventItem.type];
    // Convert start and end to Date objects.
    var start = new Date(eventItem.startTime);
    var end = new Date(eventItem.endTime);
    console.log( 'timezone=' + start.getTimezoneOffset()/60 );
    var shownParticipants = $(eventItem.participants).slice(0, NUM_VISIBLE_PARTICIPANTS);
    var unshownParticipants = $(eventItem.participants).slice(NUM_VISIBLE_PARTICIPANTS);

    // NOTE: The html variable is in single quotes to allow all the stuff
    // inside to be double-quoted (our default).
    var html = '' +
      '<div class="eventWrapper" id="event'+eventItem.eventId+'">' +
      '<div class="browseEvent">'  +
      '  <div class="topRow">' +
      '    <img class="activityIcon" src="' + activityIcons[eventItem.type] + '">';

    $(shownParticipants).each(function (index, participant) { html += '' +
      '    <img class="participantIcon" src="' + participant.pic + '">'; });
    if( unshownParticipants.length > 0 ){
    html += '' +
      '    <div class="plusMore">+' + unshownParticipants.length + '</div>';
    }
    html += '' +
      '    <img class="plusMe" src="/images/plusMe.png">' +
      '    <div class="eventTime"> '+
             dateToWeekdayAbbreviation(start) + ' ' +
             dateToHour(start) +
             '<span style="font-size:70%;color:#bbb;">' +
               dateToAmPm(start) +
             '</span>' +
              ' - ' +
              dateToWeekdayAbbreviation(end) + ' ' +
              dateToHour(end) +
              '<span style="font-size:70%;color:#bbb;">' +
                dateToAmPm(end) +
              '</span>' +
      '    </div>' +
      '    <br>' +
      '  </div>' +
      '  <div class="eventDescription">' + eventItem.details + '</div>' +
      '  <!-- for now where uses same class as desc -->' +
      '  <div class="eventWhere">' +
      '    <span style="color:#555;">Where:</span> ' + eventItem.location + '' +
      '  </div>' +
      '  <div class="numMessages">'+eventItem.messages.length+'msg</div>' +
      '</div>';
    // iterate messages, hidden by default
    html += '<div class="messagesWrapper">';
    $.each( eventItem.messages, function( index, msg ){
    var sender = eventItem.participants.filter( function( user ){ return (user.userId == msg.fromUserId); } )[0];
    html += '' +
    '<div class="message">'  +
    '    <img class="messageIcon" src="' + sender.pic + '">' +
    '    <div class="messageContents"><span class="messageSender">' + sender.name + ':</span> ' +
         msg.message + '<br>' +
         '<span class=messageTime>'+(new Date(msg.sentAt)).format('dddd, h:MM TT')+'</span>' +
         '</div>' +
    '</div>';
    } );
    // add the text box here. this needs to be modified once I know how sencha works
    html+= '<textarea class="composeMessage">your message here</textarea>';
    html+='</div>';
    html+='</div>';

    var element = $(html);
    //console.log( element );
    // make a panel out of this and add it to eventList
    eventPanelList.push( new Ext.Panel({
        id: 'event'+eventItem.eventId,
        layout: 'auto',
        dock: 'top',
        html: html,
        listeners:{
          el: {
            tap: function() {
              app.detailPanel.update( '<div style="margin:10px;">Details page for '+this.id+'</div>' );
              app.Viewport.setActiveItem('detailPanel', {type:'slide', direction:'left'}); }
            },
          scope: this,
        },
      })
    );

  };

  $.each(eventList, function(index, eventItem) {
    renderEvent(eventItem);
  });
};

// call above logic
// dont call until we get real data
//renderEvents( data );

// setup top and bottom toolbars
var buttonsSpecTop = [
  //{ ui: 'back', text: 'Back' },
  { xtype: 'spacer' },
  { xtype:'box', html:'<img src="/images/hooqlogoCenter.png" style="height:45px;">', align:'center' },
  { xtype: 'spacer' },
  { ui: 'forward', text: 'New Event', handler: function() { app.Viewport.setActiveItem('newEventPanel', {type:'slide', direction:'left'}); } },
]

var buttonsSpecBottom = [
    { ui: 'normal', text: 'Friends' },
    { ui: 'normal', text: 'Run' },
    { ui: 'normal', text: 'Climb' },
    { ui: 'normal', text: 'Yoga' },
    { ui: 'normal', text: 'Orgy' },
]

var tapHandler = function (btn, evt) {
    alert("Button '" + btn.text + "' tapped.");
};

var topToolBar = {
    xtype: 'toolbar',
    //title: 'Buttons',
    ui: 'dark',
    dock: 'top',
    items: buttonsSpecTop,
    defaults: { handler: tapHandler }
};

// doesn't do anything yet besides register clicks
var bottomToolBar = {
    xtype: 'toolbar',
    ui: 'dark',
    dock: 'bottom',
    items: buttonsSpecBottom,
    defaults: { handler: tapHandler }
};

// register xtypes for convenience
console.log( Ext.form );
Ext.reg('datefield', Ext.form.DatePicker );
Ext.reg('slider', Ext.form.Slider );
Ext.reg('radio', Ext.form.Radio );
Ext.reg('select', Ext.form.Select );
Ext.reg('spinner', Ext.form.Spinner );

// newEventPanel form - TBD if this is usable, right now skipping
fields = {
  xtype: 'fieldset',
  title: 'New Event',
  intructions: 'fill shit in',
  defaults: { xtype: 'radio', },
  items: [
    { name: 'description',
      label: 'description',
      xtype: 'textfield',
    },
    { name: 'location',
      label: 'where',
      xtype: 'textfield',
    },
    { name: 'start_time',
      label: 'Start Time:',
      xtype: 'datefield',
    },
    { name: 'slider',
      label: 'slider',
      xtype:'slider', },
    { name: 'spinner',
      label: 'spinner',
      xtype:'spinner', },
    { name: 'radio',
      label: 'radio',
      xtype:'radio',
     },
    { xtype: 'fieldset',
      layout: 'hbox',
      minHeight: 80,
      fieldlabel: 'Start Day',
      defaults: { xtype: 'radio', width: 100, },
      items:[
      { label: 'Mon',
          boxLabel: 'M',
          name: 'size',
          inputValue: 'm',
      }, { label: 'Tue',
          boxLabel: 'L',
          name: 'size',
          inputValue: 'l'
      }, { label: 'Wed',
          boxLabel: 'XL',
          name: 'size',
          inputValue: 'xl'
      }]
    },
  ],
}

// hack in mean time
var newEventForm;
var newEventHtml = '';
console.log( 'trying to get form');
$.get( '/events/new', function( data ){
  newEventForm = new Ext.form.FormPanel({
    html: data,
  });
} );

// contents for newEventPanel
var makeNewEvent = function(){
  var postdata = '';
  postdata += 'event_type_id=' + $('#event_type_id').val();
  postdata += '&details=' + $('#details').val();
  var startTime = new Date( $("input[name='start_day']:checked").val() );
  // parseInt base 10 is important or 08 and 09 turn into zero in octal
  startTime.setHours( parseInt( $('#start_time').val().substring(0,2), 10 ), 0, 0, 0);
  postdata += '&start_time=' + startTime;
  var endTime = new Date( $("input[name='end_day']:checked").val() );
  endTime.setHours( parseInt( $('#end_time').val().substring(0,2), 10 ), 0, 0, 0);
  postdata += '&end_time=' + endTime;
  postdata += '&location=' + $('#location').val();
  console.log( postdata );
  // without csrf session is reset upon post
  $.ajaxSetup({
    beforeSend: function(xhr) {
      xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
    }
  });
  // send data
  $.ajax({
    type: "POST",
    url: "/events/saveEvent",
    data: postdata,
    success: function(data) {
      console.log( 'success!' );
      //app.Viewport.setActiveItem('eventFlowPanel', {type:'slide', direction:'right'});
      //window.location.reload();
    },
    error: function(request, status, exception) {
    	alert(status + " " + exception);
    }
  });
};

dockedItems = [ topToolBar, bottomToolBar, ];

app = new Ext.Application({
  name: "Hooq",
  launch: function() {
    app.newEventPanel = new Ext.Panel({
      id: 'newEventPanel',
      dockedItems: [{
        xtype: 'toolbar',
        items: [{ text: 'Cancel',
                  ui: 'back',
                  handler: function() { app.Viewport.setActiveItem('eventFlowPanel', {type:'slide', direction:'right'}); }
               }]
      },
      ],
      items: [
      newEventForm,
      { text:'New Event', xtype:'button', ui:'normal', handler: makeNewEvent, width: 150 },
      ],
    });

    app.eventFlowPanel = new Ext.Panel({
      id: 'eventFlowPanel',
      fullscreen: true,
      scroll:'vertical',
      dockedItems: dockedItems,
      items: eventPanelList,
    });

    app.detailPanel = new Ext.Panel({
      id: 'detailPanel',
      html: '<div style="margin:10px;">Detail Panel!</div>',
      dockedItems: [{
        xtype: 'toolbar',
        items: [{ text: 'Events',
                  ui: 'back',
                  handler: function() { app.Viewport.setActiveItem('eventFlowPanel', {type:'slide', direction:'right'}); }
               }]
      }]
    });

    app.Viewport = new Ext.Panel ({
      fullscreen: true,
      layout: 'card',
      cardSwitchAnimation: 'slide',
      items: [app.eventFlowPanel, app.detailPanel, app.newEventPanel]
    });

  }
});
