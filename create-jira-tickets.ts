import {select} from "@inquirer/prompts"
import {convertToCliParameters} from "../code_generator/lib/convertToCliParameters"
import {spawnShellCommand} from "../code_generator/lib/spawnShellCommand"
import inquirer from 'inquirer'
import fs from "node:fs"
import {createTickets} from "./lib/createTickets"

prepareAndCreateTickets().then(() => true)

async function prepareAndCreateTickets() {
    const ticketTreePath = __dirname + '/_temp/ticketTree.json'
    if (fs.existsSync(ticketTreePath)) {
        fs.rmSync(ticketTreePath)
    }

    const feature = await promptFeature()
    const featureParameters = await promptFeatureParameters(feature)
    const cliParameters = convertToCliParameters(featureParameters)

    const hygenCommand = `HYGEN_OVERWRITE=1 HYGEN_TMPLS='${__dirname}' hygen features ${feature} ${cliParameters}`
    console.log(hygenCommand)
    await spawnShellCommand(hygenCommand)

    const data = JSON.parse(fs.readFileSync(ticketTreePath, 'utf8'))
    const createdTickets = await createTickets(data)
    console.log('Tickets created:', createdTickets)
}

async function promptFeature() {
    const choices = [
        // {value: 'create-node'}, // TODO currently implemented in a separate script, because of the nested prompts
        {value: 'get-node-by-id'},
        {value: 'get-all-nodes'},
        {value: 'hard-delete-node'},
        {value: 'create-relationship'},
        {value: 'get-all-relationships'},
        {value: 'get-sole-relationship'},
        {value: 'delete-relationship'},
    ]

    return select({
        message: 'Generating tickets for which feature?',
        choices,
    })
}

async function promptFeatureParameters(feature: string) {
    const questions = require(`${__dirname}/features/${feature}/prompt.js`)

    return inquirer.prompt(questions)
}
