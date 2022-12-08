

Parse.Cloud.define('getUsers', async (req) => {
    const userQuery = new Parse.Query(Parse.User);
    if (req.user) {
        userQuery.notEqualTo('objectId', req.user.id);
    }
    if (req.params.nameSearch) {
        userQuery.fullText('displayName', req.params.nameSearch);
    }
    if (req.params.limit && req.params.skip) {
        userQuery.limit(req.params.limit);
        userQuery.skip(req.params.skip);
    }
    const res = await userQuery.find();
    return res;
});