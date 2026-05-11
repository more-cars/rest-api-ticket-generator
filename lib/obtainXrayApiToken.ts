import {getXrayApiBaseUrl} from "./getXrayApiBaseUrl.ts"

export async function obtainXrayApiToken(): Promise<false | string> {
    try {
        const response = await fetch(`${getXrayApiBaseUrl()}/authenticate`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                client_id: process.env.XRAY_API_CLIENT_ID,
                client_secret: process.env.XRAY_API_CLIENT_SECRET,
            })
        })
        return response.json()
    } catch (e) {
        console.error(`Error: ${e}`)
    }

    return false
}
