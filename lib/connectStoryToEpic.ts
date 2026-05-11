import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function connectStoryToEpic(storyId: string, epicId: string) {
    await fetch(getJiraApiBaseUrl() + 'issue/' + storyId, {
        method: 'PUT',
        headers: {
            'Authorization': `Basic ${getJiraApiAuthKey()}`,
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            fields: {
                project: {
                    key: "MCA"
                },
                parent: {
                    key: epicId
                },
            }
        })
    })
}
