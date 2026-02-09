---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Get all <%= h.changeCase.upper(startNodeType) %>-<%= h.changeCase.kebab(relationshipName) %> Relationships",
            "userStory": null,
            "specificationList": [
                "A list of all ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships for the selected <%= h.changeCase.upper(startNodeType) %> is returned when there exists at least one of them. -> Status Code `200`",
                "Each item in the list contains the relationship ID and the two node IDs, but not the nodes itself.",
                "An empty list is returned when no ›<%= h.changeCase.kebab(relationshipName) %>‹ relationship exists. -> Status Code `200`",
                "Requests with invalid ID are rejected. This can happen when there exists no node with the given ID or it is not a <%= h.changeCase.upper(startNodeType) %>. -> Status Code `404`"
            ],
            "apiVerb": "GET",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(startNodeType)) %>/<<%= h.changeCase.kebab(startNodeType) %>-id>/<%= h.changeCase.kebab(relationshipName) %>",
            "responseOptions": [
                "200",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "A list of all ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships is returned when the provided data is valid",
                    "description": "To be a valid request the provided ID has to point to a <%= h.changeCase.upper(startNodeType) %> node that actually exists.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships when at least one exists",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exist 3 \\"' + h.changeCase.lower(relationshipName) + '\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests all \\"' + h.changeCase.lower(relationshipName) + '\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should return a collection with 3 \\"' + h.changeCase.lower(relationshipName) + '\\" relationships')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "An empty list is returned when there exist no ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships for the given <%= h.changeCase.upper(startNodeType) %>",
                    "description": "",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Requesting the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships when there are none",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\"')
                                gherkin.push('And there exist 0 \\"' + h.changeCase.lower(relationshipName) + '\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('When the user requests all \\"' + h.changeCase.lower(relationshipName) + '\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should return an empty list')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                },
                {
                    "title": "A request to fetch all ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships is rejected when the provided data is invalid",
                    "description": "There exists no <%= h.changeCase.upper(startNodeType) %> with the provided ID? -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to fetch the ›<%= h.changeCase.kebab(relationshipName) %>‹ relationships with an invalid <%= h.changeCase.upper(startNodeType) %> ID",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(startNodeType) + '\\" \\"' + startNodeExampleName + '\\" does NOT exist')
                                gherkin.push('When the user requests all \\"' + h.changeCase.lower(relationshipName) + '\\" relationships for \\"' + startNodeExampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        }]
    }
}
