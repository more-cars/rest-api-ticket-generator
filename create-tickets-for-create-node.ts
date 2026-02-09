import {createTickets} from "./lib/createTickets"
import data from "./_temp/ticketTree.json"

createTickets(data).then(
    createdTickets => {
        console.log('Tickets created:', createdTickets)
    })
