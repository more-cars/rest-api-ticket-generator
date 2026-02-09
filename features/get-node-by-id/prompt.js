module.exports = [
    {
        type: 'input',
        name: 'nodeType',
        message: 'Create "Get Node by ID" tickets for which node type? (e.g. "Racing Series")'
    }, {
        message: 'ID of the corresponding parent (epic) ticket? (e.g. "MCA-498")',
        name: 'epicId',
        type: 'input',
    }, {
        message: 'Example name/title/label to be used in the tests? (e.g. "Formula 1")',
        name: 'exampleName',
        type: 'input',
    }
]
