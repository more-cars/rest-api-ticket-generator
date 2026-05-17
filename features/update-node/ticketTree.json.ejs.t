---
to: _temp/ticketTree.json
---
<% const properties = JSON.parse(props) -%>
{
    "epic": {
        "jiraId": "<%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>",
        "dataStructure": null,
        "stories": [{
            "title": "Update <%= h.changeCase.upper(nodeType) %> Node",
            "userStory": "As an API contributor\nI want to be able to update a <%= h.changeCase.upper(nodeType) %>\nSo I can add missing information or fix incorrect data",
            "specificationList": [
                "A <%= h.changeCase.upper(nodeType) %> node is successfully updated when the request contains valid data. The required data structure is specified in parent (epic) ticket <%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>. -> Status Code `200`",
                "A successful request returns the updated node with all properties that are officially specified.",
                "The `updated_at` timestamp will be updated, the `created_at` timestamp not.",
                "Mandatory properties can be overwritten, but not removed. -> Status Code `400`",
                "Optional properties can be overwritten or removed. -> Status Code `200`",
                "Unknown properties are ignored. They are not processed. They do not produce any info, warning or error messages for the user. -> Status Code `200`",
                "Read-only properties (`id`, `created_at`, `updated_at`) are ignored. They are not processed. They do not produce any info, warning or error messages for the user. -> Status Code `200`",
                "Requests with invalid ID are rejected. This case can happen when there exists no node with that ID or when the node is not from type <%= h.changeCase.upper(nodeType) %>. -> Status Code `404`",
                "Requests with invalid data are rejected. Cases for invalid data include: syntax errors, wrong data types, wrong data structure or trying to remove a mandatory field. -> Status Code `400`"
            ],
            "apiVerb": "PATCH",
            "apiPath": "/<%= h.changeCase.kebab(h.inflection.pluralize(nodeType)) %>/<<%= h.changeCase.kebab(nodeType) %>-id>",
            "responseOptions": [
                "200",
                "400",
                "404"
            ],
            "acceptanceCriteria": [
                {
                    "title": "Requests to update a <%= h.changeCase.upper(nodeType) %> are accepted when the provided data is valid",
                    "description": "Data is valid when its structure is correct and has no syntax errors. Mandatory fields can be overwritten, but not deleted (via null value).",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Updating a <%= h.changeCase.upper(nodeType) %> with valid data",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    gherkin.push('  | ' + prop.name + ' | ' + (!prop.example ? '' : prop.datatype === 'number' ? Number(prop.example) + 2 : prop.example + '_2') + ' |')
                                })
                                gherkin.push('Then the request should be confirmed with status code 200')
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
                            "title": "Trying to update a non-existing <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\" does NOT exist')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\"')
                                gherkin.push('Then the request should be rejected with status code 404')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Updating a <%= h.changeCase.upper(nodeType) %> changes the updated_at timestamp",
                    "description": "",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Expecting the updated_at timestamp to change when updating a <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\"')
                                gherkin.push('Then both timestamps in the response should be different')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Requests to update a <%= h.changeCase.upper(nodeType) %> are rejected when the provided data is invalid",
                    "description": "Data is invalid when its structure is incorrect or has syntax errors. Mandatory fields may not not deleted (via null value).",
                    "responseCode": "400",
                    "tests": [
                        {
                            "title": "Trying to update a <%= h.changeCase.upper(nodeType) %> with invalid data types",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    if (prop.datatype === 'string') {
                                        gherkin.push('  | ' + prop.name + ' | 1234 |')
                                    } else if (prop.datatype === 'number') {
                                        gherkin.push('  | ' + prop.name + ' | TEST |')
                                    }
                                })
                                gherkin.push('Then the request should be rejected with status code 400')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "The response contains all properties that are officially specified when updating a <%= h.changeCase.upper(nodeType) %>",
                    "description": "All properties are returned that are specified in the epic <%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>. When properties are empty they are returned with null values. IDs, timestamp and other meta information might be included too, but is not in the scope of this AC.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Expecting all properties to be returned when updating a <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    gherkin.push('  | ' + prop.name + ' | ' + (!prop.example ? '' : prop.datatype === 'number' ? Number(prop.example) + 2 : prop.example + '_2') + ' |')
                                })
                                gherkin.push('Then the request should be confirmed with status code 200')
                                gherkin.push('And the response should contain the following properties')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    gherkin.push('  | ' + prop.name + ' | ' + (!prop.example ? '' : prop.datatype === 'number' ? Number(prop.example) + 2 : prop.example + '_2') + ' |')
                                })
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }, {
                            "title": "Expecting empty properties to be returned as null values when updating a <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    if (prop.mandatory) {
                                        gherkin.push('  | ' + prop.name + ' | ' + (!prop.example ? '' : prop.datatype === 'number' ? Number(prop.example) + 2 : prop.example + '_2') + ' |')
                                    } else {
                                        gherkin.push('  | ' + prop.name + ' |       |')
                                    }
                                })
                                gherkin.push('Then the response should contain the following properties')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    if (prop.mandatory) {
                                        gherkin.push('  | ' + prop.name + ' | ' + (!prop.example ? '' : prop.datatype === 'number' ? Number(prop.example) + 2 : prop.example + '_2') + ' |')
                                    } else {
                                        gherkin.push('  | ' + prop.name + ' |       |')
                                    }
                                })
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Unknown properties are ignored when updating a <%= h.changeCase.upper(nodeType) %>",
                    "description": "The user can provide properties that are not specified in the epic <%= h.changeCase.upper(h.changeCase.kebab(epicId)) %>, but they will be completely ignored. They will not be processed and there will be no info, warning or error that they were skipped.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Expecting unknown properties to be ignored when updating a <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key | value |')
                                gherkin.push('  | thimbleweed | park |')
                                gherkin.push('Then the response should NOT contain the following keys')
                                gherkin.push('  | key         |')
                                gherkin.push('  | thimbleweed |')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Read-only properties cannot be overridden by the user when updating a <%= h.changeCase.upper(nodeType) %>",
                    "description": "Read-only properties are for example `ID`, `created_at` and `updated_at`. Analog to unknown properties, those fields will be ignored. They will not be processed and there will be no info, warning or error that they were skipped.",
                    "responseCode": "200",
                    "tests": [
                        {
                            "title": "Expecting read-only properties to be ignored when updating a <%= h.changeCase.upper(nodeType) %>",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key        | value      |')
                                gherkin.push('  | id         | 1234       |')
                                gherkin.push('  | created_at | 2025-01-01 |')
                                gherkin.push('  | updated_at | 2025-01-01 |')
                                gherkin.push('Then the response should contain an ID')
                                gherkin.push('And the response should contain the following keys')
                                gherkin.push('  | key        |')
                                gherkin.push('  | created_at |')
                                gherkin.push('  | updated_at |')
                                gherkin.push('But the response should NOT contain the ID 1234')
                                gherkin.push('And the response should NOT contain the following properties')
                                gherkin.push('  | key        | value      |')
                                gherkin.push('  | created_at | 2025-01-01 |')
                                gherkin.push('  | updated_at | 2025-01-01 |')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }, {
                    "title": "Mandatory properties cannot be removed from a <%= h.changeCase.upper(nodeType) %>",
                    "description": "A mandatory property may be updated, but not be deleted.",
                    "responseCode": "400",
                    "tests": [
                        {
                            "title": "Trying to delete a mandatory field while updating a <%= h.changeCase.upper(nodeType) %>.",
                            <%
                                gherkin = []
                                gherkin.push('Given there exists a \\"' + h.changeCase.upper(nodeType) + '\\" \\"' + exampleName + '\\"')
                                gherkin.push('When the user updates the node \\"' + exampleName + '\\" with the following data')
                                gherkin.push('  | key | value |')
                                properties.forEach(prop => {
                                    if (prop.mandatory) {
                                        gherkin.push('  | ' + prop.name + ' |       |')
                                    }
                                })
                                gherkin.push('Then the request should be rejected with status code 400')
                            %>
                            "gherkin": "<%- gherkin.join('\\n') %>"
                        }
                    ]
                }
            ]
        }]
    }
}
