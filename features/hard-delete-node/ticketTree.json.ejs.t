---
to: ticket-generator/_temp/ticketTree.json
---
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Hard Delete <%= h.changeCase.upper(nodeType) %> Node",
            "userStory": "As an API contributor\nI want to be able to delete a <%= h.changeCase.upper(nodeType) %>\nSo I can clean up bad data, test data or redundant data",
            "specificationList": [
                "The selected <%= h.changeCase.upper(nodeType) %> node is deleted when it actually exists. -> Status Code `204`",
                "All attached relationships are also deleted when the node is deleted.",
                "Requests with invalid ID are rejected. This case can happen when there exists no node with that ID or when the node is not from type <%= h.changeCase.upper(nodeType) %>. -> Status Code `404`"
            ],
            "apiVerb": "DELETE",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(nodeType)) %>/<<%= h.changeCase.kebab(nodeType) %>-id>",
            "responseOptions": [
                "204",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Hard-deleting a <%= h.changeCase.upper(nodeType) %> permanently deletes it",
                    "description": "The only way to recover a hard-deleted node is to restore the database.",
                    "responseCode": "204",
                    "tests": [
                        {
                            "title": "Hard-deleting an existing <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user hard-deletes the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('Then the response should return with status code 204')
                                gherkin.push('And the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\" should not exist anymore')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Requests are rejected when there exists no <%= h.changeCase.upper(nodeType) %> with the provided ID",
                    "description": "When there exists no node with the provided ID -> rejected.\nWhen there exists a node with the provided ID, but it is not from type <%= h.changeCase.upper(nodeType) %> -> rejected.",
                    "responseCode": "404",
                    "tests": [
                        {
                            "title": "Trying to hard-delete a non-existing <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\" does NOT exist')
                                gherkin.push('When the user hard-deletes the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Hard-deleting a <%= h.changeCase.upper(nodeType) %> permanently deletes all attached relationships",
                    "description": "This affects all attached relationships (no matter the type) - be it internal or public relationships. Features that rely on those relationships are responsible to copy, backup or persist the data themselves.",
                    "responseCode": "204",
                    "tests": [
                        {
                            "title": "Expecting all attached relationships to be removed when hard-deleting a <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('And there exists a \\"has image\\" relationship \\"R1\\" for \\"' + exampleName + '\\"')
                                gherkin.push('And there exists a \\"has prime image\\" relationship \\"R2\\" for \\"' + exampleName + '\\"')
                                gherkin.push('When the user hard-deletes the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('Then the \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\" should not exist anymore')
                                gherkin.push('And the relationship \\"R1\\" should not exist anymore')
                                gherkin.push('And the relationship \\"R2\\" should not exist anymore')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        }]
    }
}
