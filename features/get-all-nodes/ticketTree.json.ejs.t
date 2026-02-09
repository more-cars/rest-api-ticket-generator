---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Get all <%= h.changeCase.upper(nodeType) %> Nodes",
            "userStory": "As an API consumer\nI want to be able to load all <%= h.changeCase.upper(h.inflection.pluralize(nodeType)) %> at once\nSo I can find out which even exist\nAnd to be able to compare and analyze them without having to load them all individually",
            "specificationList": [
                "A list of all <%= h.changeCase.upper(nodeType) %> nodes is returned when there exists at least 1. -> Status Code `200`",
                "When no <%= h.changeCase.upper(h.inflection.pluralize(nodeType)) %> exist then an empty list is returned. -> Status Code `200`",
                "Each returned list item contains all specified properties (see corresponding 'epic' ticket).",
                "Properties are returned, even when they are empty (optional fields). They are returned with value `null`."
            ],
            "apiVerb": "GET",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(nodeType)) %>",
            "responseOptions": [
                "200"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Requesting all nodes returns a list of <%= h.changeCase.upper(h.inflection.pluralize(nodeType)) %>",
                    "description": "In general, all existing <%= h.changeCase.upper(h.inflection.pluralize(nodeType)) %> are to be returned. But, depending on the actual amount of nodes and other features that can restrict the returned collection (like pagination or soft-deleted nodes) the response might be truncated.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting all <%= h.changeCase.upper(nodeType) %> nodes when at least 1 exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exist 3 \\"' + h.changeCase.upper(nodeType) + '\\"s')
                                gherkin.push('When the user requests all \\"' + h.changeCase.upper(nodeType) + '\\"s')
                                gherkin.push('Then the response should return a collection of 3 \\"' + h.changeCase.upper(nodeType) + '\\"s')
                                gherkin.push('And the response should return with status code 200')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "An empty list is returned when there exist no <%= h.changeCase.upper(h.inflection.pluralize(nodeType)) %>",
                    "description": "",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting all <%= h.changeCase.upper(nodeType) %> nodes when none exist",
                            <%
                                gherkin = []
                                gherkin.push('Given there exist 0 \\"' + h.changeCase.upper(nodeType) + '\\"s')
                                gherkin.push('When the user requests all \\"' + h.changeCase.upper(nodeType) + '\\"s')
                                gherkin.push('Then the response should return a collection of 0 \\"' + h.changeCase.upper(nodeType) + '\\"s')
                                gherkin.push('And the response should return with status code 200')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        }]
    }
}
