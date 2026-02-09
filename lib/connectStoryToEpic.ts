import axios from "axios"
import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function connectStoryToEpic(storyId: string, epicId: string) {
    await axios
        .put(getJiraApiBaseUrl() + 'issue/' + storyId, {
            fields: {
                'project': {
                    key: 'MCA'
                },
                'parent': {
                    key: epicId
                },
            }
        }, {
            headers: {
                'Authorization': `Basic ${getJiraApiAuthKey()}`,
                'Content-Type': 'application/json',
            }
        })
}
