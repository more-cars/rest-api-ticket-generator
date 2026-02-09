import axios from "axios"
import {getXrayApiBaseUrl} from "./getXrayApiBaseUrl.ts"

export async function obtainXrayApiToken(): Promise<false | string> {
    try {
        const response = await axios
            .post(`${getXrayApiBaseUrl()}/authenticate`, {
                client_id: process.env.XRAY_API_CLIENT_ID,
                client_secret: process.env.XRAY_API_CLIENT_SECRET,
            })
        return response.data
    } catch (e) {
        console.error(`Error: ${e}`)
    }

    return false
}
