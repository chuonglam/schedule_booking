const common = require('./common.js');

Parse.Cloud.define('createSchedule', async(req) => {
    if (!req.user) {
        throw new Parse.Error(401, 'User not logged in');
    }
    const Schedule = Parse.Object.extend('Schedule');
    const participant = new Parse.User();

    let startDate = new Date(req.params.startDate);
    let endDate = new Date(req.params.endDate);
    participant.id = req.params.participantId;

    if (participant.id === req.user.id) {
        throw new Parse.Error(400, 'Missing participant');
    }

    //validation:
    let timeSlots = await Parse.Cloud.run('getTimeSlots', {
        'participantId': req.params.participantId,
        'clientStartOfDay': req.params.clientStartOfDay
    }, {
        sessionToken: req.user.getSessionToken()
    });
    var arr = timeSlots.map(slot => [slot.get('startDate'), slot.get('endDate')]).flat(1);
    var overlaps = common.dateOverlaps([startDate, endDate], arr);
    if (overlaps === true) {
        throw new Parse.Error(403, "Time overlaps");
    }

    //create schedule:
    const schedule = new Schedule();
    schedule.set('startDate', startDate);
    schedule.set('endDate', endDate);
    schedule.set('participant', participant);
    schedule.set('host', req.user);
    await schedule.save();

    // //create/update user-schedule data: date-maxAvailableDurationInMinutes
    // let startOfDay = new Date(startDate.getTime());
    // startOfDay.setUTCHours(0, 0, 0, 0);
    // let endOfDay = new Date(startDate.getTime());
    // endOfDay.setUTCHours(23, 59, 59, 999);

    // let userTimeSlots = await Parse.Cloud.run('getUserTimeSlots', {}, {sessionToken: req.user.getSessionToken()});
    // var flattenUserTimeSlots = userTimeSlots.map(slot => [slot.get('startDate'), slot.get('endDate')]).flat(1);
    // var input = [startOfDay].concat(flattenUserTimeSlots);
    // input.push(endOfDay);

    // var availableDurations = [];
    // for(var idx = 0; idx < input.length - 2; idx += 2 ){
    //     var diffTime = input[idx + 1].getTime() - input[idx].getTime();
    //     availableDurations.push(Math.floor(diffTime / (1000 * 60)));
    // }
    // let max = Math.max(...availableDurations);
    // const UserSchedule = Parse.Object.extend('UserSchedule');
    // const userScheduleQuery = new Parse.Query(UserSchedule);
    // userScheduleQuery.equalTo('date', startOfDay);
    // userScheduleQuery.equalTo('user', req.user);
    // const userSchedule = await userScheduleQuery.first();
    // if (userSchedule) {
    //     userSchedule.set('maxAvailableDurationInMin', max);
    //     await userSchedule.save();
    // } else {
    //     const newUserSchedule = new UserSchedule();
    //     newUserSchedule.set('date', startOfDay);
    //     newUserSchedule.set('maxAvailableDurationInMin', max);
    //     newUserSchedule.set('user', req.user);
    //     await newUserSchedule.save();
    // }

    return schedule.toJSON();
});

Parse.Cloud.define('getTimeSlots', async(req) => {
    if (!req.params.participantId) {
        throw new Parse.Error(400, 'participantId is required');
    }

    const participant = new Parse.User();
    participant.id = req.params.participantId;

    const Schedule = Parse.Object.extend('Schedule');

    // --- start --- query all req.user & participant's schedules
    const participantIsHostQuery = new Parse.Query(Schedule);
    participantIsHostQuery.equalTo('host', participant);
    var hostQuery;
    if (req.user) {
        const userIsHostQuery = new Parse.Query(Schedule);
        userIsHostQuery.equalTo('host', req.user);
        hostQuery = Parse.Query.or(participantIsHostQuery, userIsHostQuery);
    } else {
        hostQuery = participantIsHostQuery;
    }

    const participantIsParticipantQuery = new Parse.Query(Schedule);
    participantIsParticipantQuery.equalTo('participant', participant);
    var participantQuery;
    if (req.user) {
        const userIsParticipantQuery = new Parse.Query(Schedule);
        userIsParticipantQuery.equalTo('participant', participant);
        participantQuery = Parse.Query.or(participantIsParticipantQuery, userIsParticipantQuery);
    } else {
        participantQuery = participantIsParticipantQuery;
    }
     
    var query = Parse.Query.or(hostQuery, participantQuery);
    // --- end ---

    const startOfDay = new Date(req.params.clientStartOfDay);
    const endOfDay = common.getEndOfDay(startOfDay);

    query.include('host', 'participant');
    query.select('objectId', 'startDate', 'endDate', 'host', 'participant');
    console.log('start = ' + startOfDay + ', end = ' + endOfDay);
    query.greaterThanOrEqualTo('startDate', startOfDay);
    query.lessThanOrEqualTo('startDate', endOfDay);

    let res = await query.find();
    return res;
});

Parse.Cloud.define('getUserTimeSlots', async(req) => {
    if (!req.user) {
        throw new Parse.Error(401, 'User not logged in');
    }
    const Schedule = Parse.Object.extend('Schedule');

    const hostQuery = new Parse.Query(Schedule);
    hostQuery.equalTo('host', req.user);

    const participantQuery = new Parse.Query(Schedule);
    participantQuery.equalTo('participant', req.user);

    const startOfDay = new Date(req.params.clientStartOfDay);
    const endOfDay = common.getEndOfDay(startOfDay);

    const query = Parse.Query.or(hostQuery, participantQuery);
    query.include('host', 'participant');
    query.select('objectId', 'startDate', 'endDate', 'host', 'participant');
    query.greaterThan('startDate', startOfDay);
    query.lessThan('startDate', endOfDay);

    if (req.params.skip && req.params.limit) {
        query.skip(req.params.skip);
        query.limit(req.params.limit);
    }

    let res = await query.find();
    return res;
});