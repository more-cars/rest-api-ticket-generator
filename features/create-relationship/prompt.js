module.exports = [
    {
        message: "Type of the first node in the relationship?",
        name: 'startNodeType',
        type: 'input',
    },
    {
        message: 'What is a good example for the name of the first node?',
        name: 'startNodeExampleName',
        type: 'input',
    },
    {
        message: "Node type of the relationship partner?",
        name: 'endNodeType',
        type: 'input',
    },
    {
        message: 'What is a good example for the name of the partner node?',
        name: 'endNodeExampleName',
        type: 'input',
    },
    {
        message: "Name of the relationship?",
        name: 'relationshipName',
        type: 'input',
    },
    {
        message: "Cardinality of the relationship?",
        name: 'cardinality',
        type: 'select',
        choices: [
            '1:1',
            '1:n',
            'n:1',
            'm:n',
        ],
    },
    {
        message: 'ID of the corresponding parent (epic) ticket? (e.g. "MCA-498")',
        name: 'epicId',
        type: 'input',
    }
]
