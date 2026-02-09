export function getJiraApiAuthKey(): false | string {
    if (!process.env.JIRA_API_USERNAME || !process.env.JIRA_API_TOKEN) {
        return false
    }

    const username = process.env.JIRA_API_USERNAME
    const apiToken = process.env.JIRA_API_TOKEN

    return Buffer.from(`${username}:${apiToken}`).toString('base64')
}
