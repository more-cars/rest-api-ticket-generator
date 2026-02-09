import type {Epic} from "./types/Epic"
import axios from "axios"
import {getJiraApiBaseUrl} from "./getJiraApiBaseUrl"
import {getJiraApiAuthKey} from "./getJiraApiAuthKey"

export async function updateEpic(data: Epic): Promise<number> {
    if (!data.dataStructure) {
        return 304
    }

    const response = await axios
        .put(getJiraApiBaseUrl() + 'issue/' + data.jiraId, {
            fields: {
                'customfield_10764': {
                    version: 1,
                    type: 'doc',
                    content: [
                        {
                            "type": "paragraph",
                            "content": [
                                {
                                    "type": "text",
                                    "text": JSON.stringify(data.dataStructure, null, 2),
                                },
                            ]
                        }
                    ]
                },
            }
        }, {
            headers: {
                'Authorization': `Basic ${getJiraApiAuthKey()}`,
                'Content-Type': 'application/json',
            }
        })

    return response.status
}
