module.exports = {
    isOverlapsed: function(firstSchedule, secondSchedule) {
        // if (firstSchedule.start <= secondSchedule.start && secondSchedule.start <= firstSchedule.end) return true;
        // if (firstSchedule.start <= secondSchedule.end  && secondSchedule.end   <= firstSchedule.end) return true;
        // if (secondSchedule.start <  firstSchedule.start && firstSchedule.end   <  secondSchedule.end) return true;
        if (firstSchedule.start <= secondSchedule.start && secondSchedule.start < firstSchedule.end) return true;
        if (firstSchedule.start < secondSchedule.end && secondSchedule.end <= firstSchedule.end) return true;
        if (secondSchedule.start < firstSchedule.start && firstSchedule.end < secondSchedule.end) return true;
        return false;
    },

    dateOverlaps: function(cur, list) {
        var idx;
        for (idx = 0; idx < list.length - 2; idx += 2) {
            if (
                module.exports.isOverlapsed(
                    {start: cur[0], end: cur[1]},
                    {start: list[idx], end: list[idx+1]}
                )
            ) {
                console.log(list[idx] + '-' + list[idx+1]);
                return true;
            }
        }
        return false;
    },

    getEndOfDay: function(start) {
        const endOfDay = new Date(start.getTime() + 24 * 60 * 60 * 1000 - 1);
        return endOfDay;
    }
}