import type {Story} from "./Story"
import type {AcceptanceCriterion} from "./AcceptanceCriterion"
import type {Test} from "./Test"
import type {PropertyDataStructure} from "./PropertyDataStructure"

export type TicketTree = {
    epic: {
        jiraId: string
        dataStructure: PropertyDataStructure[] | null
        stories: Array<Story & {
            acceptanceCriteria: Array<AcceptanceCriterion & {
                tests: Test[]
            }>
        }>
    }
}
