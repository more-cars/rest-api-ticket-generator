import axios from "axios"
import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function transitionJiraTicket(ticketId: string, transitionId: string) {
    await axios
        .post(getJiraApiBaseUrl() + 'issue/' + ticketId + '/transitions', {
            transition: {
                'id': transitionId,
            }
        }, {
            headers: {
                'Authorization': `Basic ${getJiraApiAuthKey()}`,
                'Content-Type': 'application/json',
            }
        })
}
