export function getJiraApiBaseUrl() {
    if (!process.env.JIRA_DOMAIN) {
        return false
    }

    return `${process.env.JIRA_DOMAIN}/rest/api/3/`
}
