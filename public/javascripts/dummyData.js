// Register the Event model with Sencha.
// The lookup store is wired together with our list at the end of the file
Ext.regModel('Event', {
    fields: ['eventId', 'creatorUserId', 'participants', 'type', 'details', 'start', 'end', 'createdAtLocation', 'location', 'messages' ]
});

var types = {
  "running": 1,
  "yoga": 2,
  "climbing": 3
}
var typeNames = {
  1: "running",
  2: "yoga",
  3: "climbing"
}

function hoursAfter(date, hours) {
  return new Date(date.valueOf() + 1000*60*60*hours).valueOf();
}
var NOW = new Date();


// This first one is an event you created, and you're the only one going.
var eventList = [
  { eventId: 1,
    creatorUserId: 1,
    participants: [ { userId: 1,
                     name: "Mason Simon",
                     pic: "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcQunmaNuxGPq7Z3NNkaeYvtNviM3m6UvE-w0vKnuRdswlh0PuMu" } ],
    type: 1,
    details: "~5miler in the Presidio",
    start: hoursAfter(NOW, 3),
    end: hoursAfter(NOW, 5),
    createdAtLocation: { lat: 37.75155, lng: -122.4271 },
    location: "somewhere in sf",
    messages: [ { message: "yo anyone coming to this?",
                  messageId: 12412147,
                  fromUserId: 1,
                  sentAt: hoursAfter(NOW, 1) } ] },

  // Here's another one you created, with a couple people going.
  { eventId: 2,
    creatorUserId: 1,
    participants: [{ userId: 1,
                     name: "Mason Simon",
                     pic: "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcQunmaNuxGPq7Z3NNkaeYvtNviM3m6UvE-w0vKnuRdswlh0PuMu" },
                   { userId: 2,
                     name: "Sean Holbert",
                     pic: "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcTxQ0tPZkHRHar3zmvcEByhdEhN5oz15qkux-xOYskA226Y8l5odg" } ],
    type: 2,
    details: "you down for downward dog, dawg?",
    start: hoursAfter(NOW, 27),
    end: hoursAfter(NOW, 30),
    createdAtLocation: { lat: 37.75155, lng: -122.4271 },
    location: "the mission",
    messages: [ { message: "i'm so tight right now",
                  messageId: 12412149,
                  fromUserId: 2,
                  sentAt: hoursAfter(NOW, 1.5) },
                { message: "6p at Mission Cliffs work?",
                  messageId: 12412157,
                  fromUserId: 1,
                  sentAt: hoursAfter(NOW, 1.6)},
                { message: "yea",
                  messageId: 12412160,
                  fromUserId: 2,
                  sentAt: hoursAfter(NOW, 1.5)},
                { message: "NAMASTE BITCHES",
                  messageId: 12412171,
                  fromUserId: 1,
                  sentAt: hoursAfter(NOW, 4.1) } ] },

  // Here's an event someone else made, that no one else is going to.
  { eventId: 3,
    creatorUserId: 3,
    participants: [ { userId: 3,
                      name: "Ashwin Mudaliar",
                      pic: "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcTOugRH2peeiRniAvvZGBDG2MEjfJD54TVGFAByO-RqEdZi3pXgIA" } ],
    type: 1,
    details: "short and hard",
    start: hoursAfter(NOW, 40),
    end: hoursAfter(NOW, 44),
    createdAt: { lat: 37.75636, lng: -122.4304 },
    createdAtLocation: "around Noe Valley",
    messages: [] },

  // Here's an event someone else made, that a few people (not including you) are going to.
  { eventId: 4,
    creatorUserId: 4,
    participants: [ { userId: 4,
                      name: "Dwight Crow",
                      pic: "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcQ4jaEFxaxiDdA57OSYgWbhq5ugZTOXELcoKnv6W_KP-xQ5d6zt" },
                    { userId: 2,
                      name: "Sean Holbert",
                      pic: "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcTxQ0tPZkHRHar3zmvcEByhdEhN5oz15qkux-xOYskA226Y8l5odg" },
                    { userId: 3,
                      name: "Ashwin Mudaliar",
                      pic: "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcTOugRH2peeiRniAvvZGBDG2MEjfJD54TVGFAByO-RqEdZi3pXgIA" } ],
    type: 3,
    details: "let's get high: climb the TransAm building",
    start: hoursAfter(NOW, 60),
    end: hoursAfter(NOW, 69),
    createdAtLocation: { lat: 37.7950, lng: -122.4035 },
    location: "FiDi",
    messages: [ { message: "how bout at 2pm?",
                  messageId: 12412185,
                  fromUserId: 2,
                  sentAt: hoursAfter(NOW, 14) },
                { message: "can't do 2. 3 works tho",
                  messageId: 12412188,
                  fromUserId: 4,
                  sentAt: hoursAfter(NOW, 15) },
                { message: "i can do 3",
                  messageId: 12412189,
                  fromUserId: 2,
                  sentAt: hoursAfter(NOW, 15.3) },
                { message: "me 2",
                  messageId: 12412193,
                  fromUserId: 3,
                  sentAt: hoursAfter(NOW, 16) },
                { message: "done. 3pm in front of the TransAm building",
                  messageId: 12412195,
                  fromUserId: 4,
                  sentAt: hoursAfter(NOW, 15.3) } ] },

    // Here's an event someone else made, that a few people are going to, that doesn't have any messages
    {
    eventId: 5,
    creatorUserId: 4,
    participants: [ { userId: 4,
                      name: "Dwight Crow",
                      pic: "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcQ4jaEFxaxiDdA57OSYgWbhq5ugZTOXELcoKnv6W_KP-xQ5d6zt" },
                    { userId: 2,
                      name: "Sean Holbert",
                      pic: "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcTxQ0tPZkHRHar3zmvcEByhdEhN5oz15qkux-xOYskA226Y8l5odg" },
                    { userId: 3,
                      name: "Ashwin Mudaliar",
                      pic: "https://encrypted-tbn2.google.com/images?q=tbn:ANd9GcTOugRH2peeiRniAvvZGBDG2MEjfJD54TVGFAByO-RqEdZi3pXgIA" },
                    { userId: 1,
                      name: "Mason Simon",
                      pic: "https://encrypted-tbn3.google.com/images?q=tbn:ANd9GcQunmaNuxGPq7Z3NNkaeYvtNviM3m6UvE-w0vKnuRdswlh0PuMu" } ],
    type: 3,
    details: "exploding shit. same alley as usual?",
    start: hoursAfter(NOW, 42),
    end: hoursAfter(NOW, 43),
    createdAtLocation: { lat: 37.8150, lng: -122.4035 },
    location: "alley",
    messages: [ ] }
];



Hooqup.ListStore = new Ext.data.Store({
    model: 'Event',
    sorters: 'start',
    // add group by day later
    //getGroupString : function(record) {
    //    return record.get('lastName')[0];
    //},
    data: eventList,
});

