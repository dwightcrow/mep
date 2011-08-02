var rootPanel;
var eventPanelList = [];

console.log( data );

// create each event panel programatically and add to eventList
// We'll have this from authentication; probly not with this exact var name.
var CURRENT_USER_ID = 1;

console.log( 1 );

// How many participant pics show up in each event?
var NUM_VISIBLE_PARTICIPANTS = 3;

var activityIcons = {
  1: '/images/activity.jpg',
  2: '/images/activity.jpg',
  3: '/images/activity.jpg'
};

/*
$(document).ready(function() {
  console.log( 'getting called');
  renderEvents(data);
  $('.browseEvent').click( toggleMessages );
  $('#content').show();
});
*/

/* Returns the 2-letter weekday abbreviation for the weekday of a given date. */
var weekdayAbbreviations = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
var dateToWeekdayAbbreviation = function(date) {
  return weekdayAbbreviations[date.getDay()];
};

console.log( 2 );

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

console.log( 3 );
/* Renders DOM elements for all the events.
 */
var renderEvents = function(eventList) {
console.log( eventList );
console.log( 4 );

  var renderEvent = function(eventItem) {
    var createdByMe = eventItem.creatorId === CURRENT_USER_ID;
    var typeName = typeNames[eventItem.type];
console.log( 5 );
    // Convert start and end to Date objects.
    var start = new Date(eventItem.start);
    var end = new Date(eventItem.end);

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
console.log( 6 );
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
              '-' +
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
    console.log( element );
    // make a panel out of this and add it to eventList
    eventPanelList.push( new Ext.Panel({
        dock: 'top',
        html: html,
    })
    );
  };

  $.each(eventList, function(index, eventItem) {
    renderEvent(eventItem);
  });
};

// call function and make app
renderEvents( data );
Ext.setup({
  onReady: function() {
    rootPanel = new Ext.Panel({
      fullscreen: true,
      dockedItems: eventPanelList,
    });
  }
});

