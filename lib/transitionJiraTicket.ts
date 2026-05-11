import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function transitionJiraTicket(ticketId: string, transitionId: string) {
    await fetch(getJiraApiBaseUrl() + 'issue/' + ticketId + '/transitions', {
        method: 'POST',
        headers: {
            'Authorization': `Basic ${getJiraApiAuthKey()}`,
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            transition: {
                "id": transitionId,
            }
        })
    })
}
