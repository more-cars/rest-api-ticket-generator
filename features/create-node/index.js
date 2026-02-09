module.exports = {
    prompt: async ({inquirer}) => {
        const questions = [{
            message: 'Create "Create Node" tickets for which node type? (e.g. "Racing Series")',
            name: 'nodeType',
            type: 'input',
        }, {
            message: 'ID of the corresponding parent (epic) ticket? (e.g. "MCA-498")',
            name: 'epicId',
            type: 'input',
        }, {
            message: 'Example name/title/label to be used in the tests? (e.g. "Formula 1")',
            name: 'exampleName',
            type: 'input',
        }, {
            message: 'Please list all properties that the user is allowed to modify (comma-separated list):',
            name: 'properties',
            type: 'list',
        }]

        return inquirer
            .prompt(questions)
            .then(answers => {
                const {properties} = answers
                const questions = []

                properties.forEach((prop) => {
                    questions.push({
                        message: `Is the property "${prop}" a mandatory field?`,
                        name: 'properties.' + prop + '.mandatory',
                        type: 'confirm',
                    })

                    questions.push({
                        message: `Data type of property "${prop}"?`,
                        name: 'properties.' + prop + '.datatype',
                        type: 'select',
                        choices: ['string', 'number', 'boolean'],
                    })

                    questions.push({
                        message: `Example of property "${prop}"?`,
                        name: 'properties.' + prop + '.example',
                        type: 'input',
                    })
                })

                return inquirer
                    .prompt(questions)
                    .then(nextAnswers => Object.assign({}, answers, nextAnswers))
            })
    }
}
