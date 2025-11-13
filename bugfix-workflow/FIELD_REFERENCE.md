# Bug Fix Workflow - Field Reference

Quick reference guide for all configuration fields in `ambient.json`.

## Core Required Fields

### name
- **Type:** String
- **Required:** Yes
- **Description:** Display name shown in Claude Code UI/CLI
- **Best Practice:** 2-5 words, action-oriented, title case
- **Example:** `"Bug Fix Workflow"`

### description
- **Type:** String
- **Required:** Yes
- **Description:** Detailed explanation of workflow purpose and when to use it
- **Best Practice:** 1-3 sentences explaining functionality
- **Example:** `"A comprehensive workflow for bug triage, root cause analysis, fix implementation, and verification with automated regression testing."`

### systemPrompt
- **Type:** String (Multiline)
- **Required:** Yes
- **Description:** Core instructions defining the AI agent's role, responsibilities, and methodology
- **Contains:**
  - Role definition
  - Key responsibilities
  - Workflow phases/methodology
  - Available commands
  - Output locations
  - Best practices
  - Collaboration instructions
- **Example:** See `.ambient/ambient.json` for full example

### startupPrompt
- **Type:** String (Multiline)
- **Required:** Yes
- **Description:** Initial greeting and instructions shown when workflow starts
- **Contains:**
  - Welcome message
  - Available commands list
  - Getting started steps
  - Quick tips
  - Agent persona information
- **Example:** See `.ambient/ambient.json` for full example

## Optional Configuration Fields

### version
- **Type:** String
- **Required:** No
- **Description:** Semantic version number for the workflow
- **Format:** `"MAJOR.MINOR.PATCH"`
- **Example:** `"1.0.0"`

### icon
- **Type:** String (Emoji)
- **Required:** No
- **Description:** Emoji identifier for the workflow
- **Example:** `"🐛"`

### tags
- **Type:** Array of Strings
- **Required:** No
- **Description:** Keywords for workflow discovery and categorization
- **Example:** `["bugfix", "debugging", "testing", "quality-assurance"]`

### results
- **Type:** Object
- **Required:** No (but recommended)
- **Description:** Maps output artifact categories to file path patterns
- **Supports:** Glob patterns (`*`, `**`)
- **Format:** `{ "Category Name": "path/pattern/**/*.ext" }`
- **Example:**
```json
{
  "Bug Reports": "artifacts/bugs/**/*.md",
  "Root Cause Analyses": "artifacts/bugs/**/analysis.md",
  "Fix Implementations": "artifacts/bugs/**/fix.md",
  "Test Results": "artifacts/bugs/**/tests/**/*",
  "Verification Reports": "artifacts/bugs/**/verification.md"
}
```

### author
- **Type:** String or Object
- **Required:** No
- **Description:** Workflow author information
- **String Format:** `"Author Name"`
- **Object Format:**
```json
{
  "name": "Author Name",
  "email": "author@example.com",
  "organization": "Company Name"
}
```

### repository
- **Type:** String or Object
- **Required:** No
- **Description:** Source code repository information
- **String Format:** `"https://github.com/user/repo"`
- **Object Format:**
```json
{
  "type": "git",
  "url": "https://github.com/user/repo",
  "directory": "workflows/bugfix"
}
```

### license
- **Type:** String
- **Required:** No
- **Description:** Software license type
- **Example:** `"MIT"`, `"Apache-2.0"`, `"GPL-3.0"`

### displayName
- **Type:** String
- **Required:** No
- **Description:** Alternative display name (if different from `name`)
- **Example:** `"BugFix Pro Workflow"`

### dependencies
- **Type:** Object or Array
- **Required:** No
- **Description:** Required tools, packages, or other workflows
- **Object Format:**
```json
{
  "tools": ["git", "npm", "jest"],
  "workflows": ["code-review-workflow"],
  "packages": {
    "jest": ">=29.0.0",
    "eslint": ">=8.0.0"
  }
}
```

### environment
- **Type:** Object
- **Required:** No
- **Description:** Environment variables or configuration
- **Example:**
```json
{
  "ARTIFACTS_PATH": "artifacts/bugs",
  "TEST_TIMEOUT": "30000",
  "COVERAGE_THRESHOLD": "80"
}
```

### settings
- **Type:** Object
- **Required:** No
- **Description:** Workflow-specific settings and preferences
- **Example:**
```json
{
  "autoCreateBugId": true,
  "requireReproduction": true,
  "minCoveragePercent": 80,
  "autoInvokeAgents": false
}
```

### hooks
- **Type:** Object
- **Required:** No
- **Description:** Lifecycle hooks for automation
- **Available Hooks:**
  - `pre-init`: Before workflow initialization
  - `post-init`: After workflow initialization
  - `pre-command`: Before each command execution
  - `post-command`: After each command execution
  - `pre-verify`: Before verification phase
  - `post-verify`: After verification phase
- **Example:**
```json
{
  "pre-init": "git status",
  "post-verify": "npm run lint && npm test",
  "pre-command": "echo 'Running command...'"
}
```

### metadata
- **Type:** Object
- **Required:** No
- **Description:** Custom metadata for tracking or categorization
- **Example:**
```json
{
  "category": "quality-assurance",
  "complexity": "intermediate",
  "estimatedTime": "2-4 hours",
  "team": "platform-team"
}
```

## Slash Command File Structure

Location: `.claude/commands/{command-name}.md`

Each command file should include:

```markdown
# /command-name - Short Description

## Purpose
What this command accomplishes

## Prerequisites
- Required conditions before running

## Arguments
- argument_name (required/optional): Description

## Process
1. Step-by-step process description
2. What the command does
3. How it processes data

## Output
- Files created or modified
- Status updates

## Usage Examples
```
/command-name argument
```

## Output Format
Expected structure of generated files

## Notes
Important caveats and considerations
```

## Agent Persona File Structure

Location: `.claude/agents/{agent-name}.md`

Each agent file should include:

```markdown
# Agent Name - Role Title

## Role
Brief description of the agent's role

## Expertise
- Area 1
- Area 2
- Area 3

## Responsibilities
Detailed list of what the agent does

## Communication Style
How the agent communicates

## When to Invoke
Situations where this agent is useful

## Tools and Techniques
Methods and tools the agent uses

## Key Principles
Guiding principles (numbered list)

## Example Artifacts
What this agent produces
```

## File Path Patterns

### Glob Pattern Support
- `*` - Matches any characters except `/`
- `**` - Matches any characters including `/`
- `?` - Matches exactly one character
- `{a,b}` - Matches `a` or `b`
- `[abc]` - Matches any character in the set

### Common Patterns
- `**/*.md` - All markdown files recursively
- `artifacts/bugs/*/analysis.md` - Analysis files in any bug directory
- `**/*.{js,ts}` - All JavaScript and TypeScript files
- `tests/**/*` - All files in tests directory

## Best Practices

### Configuration
1. **Keep it focused** - One workflow per process type
2. **Clear naming** - Use descriptive, action-oriented names
3. **Document outputs** - Use `results` field to specify artifacts
4. **Version properly** - Use semantic versioning
5. **Tag appropriately** - Help users discover your workflow

### Commands
1. **Single responsibility** - Each command does one thing well
2. **Clear prerequisites** - State what's needed before running
3. **Document outputs** - Specify where files are created
4. **Provide examples** - Show real usage patterns
5. **Error handling** - Explain what to do when things go wrong

### Agent Personas
1. **Define expertise clearly** - What the agent is good at
2. **Specify invocation scenarios** - When to use the agent
3. **Show communication style** - How the agent responds
4. **Provide examples** - Real interaction patterns
5. **List artifacts** - What the agent produces

## Validation

### Required Field Validation
```javascript
// Minimal valid ambient.json
{
  "name": "Workflow Name",
  "description": "Workflow description",
  "systemPrompt": "You are...",
  "startupPrompt": "Welcome..."
}
```

### Recommended Fields
```javascript
{
  "name": "Bug Fix Workflow",
  "description": "Comprehensive bug fix workflow",
  "version": "1.0.0",
  "icon": "🐛",
  "tags": ["bugfix", "debugging"],
  "systemPrompt": "...",
  "startupPrompt": "...",
  "results": {
    "Artifacts": "artifacts/**/*"
  }
}
```

### Complete Example
See `.ambient/ambient.json` in this workflow for a complete, production-ready example.

## Common Patterns

### Bug/Issue Tracking Workflow
```json
{
  "results": {
    "Bug Reports": "artifacts/bugs/**/*.md",
    "Test Results": "artifacts/bugs/**/tests/**/*"
  }
}
```

### Feature Development Workflow
```json
{
  "results": {
    "Specifications": "artifacts/specs/**/*.md",
    "Implementation": "artifacts/implementation/**/*",
    "Documentation": "artifacts/docs/**/*.md"
  }
}
```

### Code Review Workflow
```json
{
  "results": {
    "Reviews": "artifacts/reviews/**/*.md",
    "Suggestions": "artifacts/suggestions/**/*",
    "Security Reports": "artifacts/security/**/*.md"
  }
}
```

## Troubleshooting

### "Field not recognized"
- Check spelling and capitalization
- Ensure field is in the root object
- Verify JSON syntax is valid

### "Results pattern not matching"
- Test glob patterns with files present
- Use `**` for recursive matching
- Ensure file extensions match

### "Agent persona not loading"
- Check file is in `.claude/agents/`
- Verify markdown formatting
- Ensure file has `.md` extension

## Resources

- **Template Workflow:** Reference implementation with all fields
- **Claude Code Documentation:** Official platform documentation
- **JSON Schema:** Validate your configuration
- **Examples:** See other workflows for patterns

---

For more details, see the main README.md or individual command documentation in `.claude/commands/`.
