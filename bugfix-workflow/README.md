# Bug Fix Workflow

A comprehensive workflow for systematic bug triage, root cause analysis, fix implementation, and verification with automated regression testing.

## Overview

The Bug Fix Workflow provides a structured, methodical approach to diagnosing and resolving bugs. It guides you through five key phases: reproduction, analysis, fixing, testing, and verification. Each phase builds on the previous one to ensure bugs are properly understood, fixed at the root cause level, and prevented from recurring.

## Quick Start

1. **Install the workflow** in your Claude Code workspace
2. **Start with** `/reproduce "<bug description>"` to begin the workflow
3. **Follow the phases** in order: reproduce → analyze → fix → test → verify
4. **Review artifacts** in `artifacts/bugs/{bug-id}/` for all documentation

## Workflow Phases

### 1. Reproduce (`/reproduce`)
Systematically reproduce the bug and document reproduction steps.

**What it does:**
- Creates a unique bug ID and directory structure
- Gathers bug information from the codebase
- Documents exact reproduction steps
- Creates a failing test case that demonstrates the bug
- Captures environment details, error messages, and logs

**Output:**
- `artifacts/bugs/{bug-id}/reproduction.md`
- `artifacts/bugs/{bug-id}/tests/reproduction-test.{ext}`
- Bug status: `REPRODUCED`

**Example:**
```
/reproduce "Users unable to login with valid credentials on mobile devices"
```

### 2. Analyze (`/analyze`)
Perform root cause analysis to identify the underlying issue.

**What it does:**
- Reviews reproduction documentation
- Investigates affected code sections
- Traces execution flow to identify failure points
- Forms and tests hypotheses about the root cause
- Analyzes impact and identifies similar patterns
- Documents detailed findings and recommendations

**Output:**
- `artifacts/bugs/{bug-id}/analysis.md`
- Bug status: `ANALYZED`

**Example:**
```
/analyze
```

### 3. Fix (`/fix`)
Implement the bug fix based on root cause analysis.

**What it does:**
- Reviews analysis and recommended fix approach
- Implements code changes to address the root cause
- Updates or creates tests to verify the fix
- Applies similar fixes to related patterns
- Documents implementation decisions and changes
- Ensures backward compatibility

**Output:**
- `artifacts/bugs/{bug-id}/fix.md`
- Modified source code files
- Updated test files
- Bug status: `FIXED`

**Example:**
```
/fix
```

### 4. Test (`/test`)
Create comprehensive regression tests and validate the fix.

**What it does:**
- Creates regression test suite
- Executes all tests (unit, integration, E2E)
- Verifies test coverage
- Performs manual testing if needed
- Runs performance benchmarks
- Documents test results

**Output:**
- `artifacts/bugs/{bug-id}/tests/test-results.md`
- `artifacts/bugs/{bug-id}/tests/regression-test.{ext}`
- Coverage reports
- Bug status: `TESTED`

**Example:**
```
/test
```

### 5. Verify (`/verify`)
Perform final verification and generate deployment-ready report.

**What it does:**
- Reviews all artifacts for consistency
- Performs final code review
- Validates deployment readiness
- Creates deployment checklist
- Generates comprehensive verification report
- Documents lessons learned

**Output:**
- `artifacts/bugs/{bug-id}/verification.md`
- `artifacts/bugs/{bug-id}/deployment-checklist.md`
- `artifacts/bugs/{bug-id}/summary.md`
- Bug status: `VERIFIED`

**Example:**
```
/verify
```

## Artifact Organization

All bug-related artifacts are organized in a structured directory:

```
artifacts/
└── bugs/
    └── {bug-id}/
        ├── reproduction.md          # Reproduction steps and details
        ├── analysis.md              # Root cause analysis
        ├── fix.md                   # Fix implementation details
        ├── verification.md          # Final verification report
        ├── deployment-checklist.md  # Deployment guide
        ├── summary.md               # Executive summary
        ├── lessons-learned.md       # Lessons learned
        ├── tests/                   # Test files
        │   ├── reproduction-test.*  # Failing test demonstrating bug
        │   ├── regression-test.*    # Regression test suite
        │   ├── test-results.md      # Test execution results
        │   └── coverage/            # Coverage reports
        ├── logs/                    # Log files and traces
        └── screenshots/             # Visual evidence
```

## Agent Personas

The workflow includes three specialized agent personas you can invoke for specific tasks:

### @debugger-alex - Senior Debugging Specialist
- **Expertise:** Systematic debugging, code tracing, root cause analysis
- **Invoke for:** Reproducing bugs, analyzing execution flow, identifying race conditions
- **Specialties:** Performance profiling, memory leak detection, stack trace analysis

### @tester-sam - Quality Assurance Engineer
- **Expertise:** Test design, test automation, quality assurance
- **Invoke for:** Creating test suites, increasing coverage, cross-platform testing
- **Specialties:** TDD/BDD, integration testing, performance testing

### @reviewer-jordan - Code Review Specialist
- **Expertise:** Code quality, security vulnerabilities, maintainability
- **Invoke for:** Code reviews, security assessment, architecture validation
- **Specialties:** Security review, performance optimization, technical debt evaluation

## Features

### Systematic Approach
- Structured five-phase workflow ensures nothing is missed
- Each phase builds on previous work
- Clear handoffs between phases with documented outputs

### Comprehensive Documentation
- Every step is documented for future reference
- Knowledge sharing across team members
- Audit trail for compliance and learning

### Quality Assurance
- Emphasis on root cause, not symptoms
- Regression test creation prevents recurrence
- Multiple levels of validation before deployment

### Deployment Readiness
- Staged deployment checklist
- Risk assessment and rollback planning
- Monitoring and observability guidance

## Best Practices

### 1. Follow the Phases in Order
Don't skip ahead. Each phase relies on the previous one's output.

### 2. Reproduce Before Fixing
Always establish reliable reproduction before attempting to fix. You can't verify a fix if you can't reproduce the bug.

### 3. Focus on Root Causes
Don't just patch symptoms. Understand why the bug occurs and fix the underlying issue.

### 4. Test Comprehensively
Create tests that would have caught the bug originally. Include edge cases and boundary conditions.

### 5. Document Everything
Future developers (including you) will thank you for thorough documentation.

### 6. Consider Similar Patterns
If you found one bug, look for similar patterns elsewhere in the codebase.

### 7. Think About Prevention
What processes, tools, or practices could prevent this type of bug in the future?

## Configuration

### Workflow Configuration File: `.ambient/ambient.json`

Key configuration fields:
- **name:** "Bug Fix Workflow"
- **description:** Workflow purpose and usage
- **systemPrompt:** Core instructions for the AI agent
- **startupPrompt:** Initial greeting and instructions
- **results:** Maps artifact types to file paths

See `FIELD_REFERENCE.md` for detailed configuration options.

## Examples

### Example 1: Authentication Bug
```bash
# Phase 1: Reproduce
/reproduce "Login fails with valid credentials on mobile Safari"

# Phase 2: Analyze (discovers race condition in async validation)
/analyze

# Phase 3: Fix (adds proper async/await handling)
/fix

# Phase 4: Test (creates regression tests, all pass)
/test

# Phase 5: Verify (generates deployment-ready report)
/verify
```

### Example 2: API Timeout Bug
```bash
# Start with detailed description
/reproduce "API returns 500 error when pagination offset exceeds total records"

# Follow through phases
/analyze
/fix
/test
/verify
```

## Troubleshooting

### "Cannot find bug documentation"
Ensure you've run `/reproduce` first to create the bug directory and documentation.

### "Tests are failing after fix"
Review the fix implementation in `fix.md` and ensure all edge cases are handled. Use `/test` again after making corrections.

### "How do I invoke an agent persona?"
Use the `@` symbol: `@debugger-alex help me trace this code path`

## Advanced Usage

### Handling Multiple Bugs
Each bug gets its own directory under `artifacts/bugs/{bug-id}/`. You can work on multiple bugs in parallel.

### Customizing the Workflow
1. Edit `.ambient/ambient.json` to modify prompts or output locations
2. Edit slash command files in `.claude/commands/` to change behavior
3. Add new agent personas in `.claude/agents/` for specialized needs

### Integration with Issue Tracking
Bug IDs can match your issue tracker (e.g., `JIRA-1234`, `GH-567`) for easy correlation.

## Contributing

Found ways to improve this workflow? Contributions are welcome!

1. Fork the repository
2. Make your changes
3. Test thoroughly in a real workflow session
4. Submit a pull request with examples

## License

MIT License - see LICENSE file for details

## Support

- **Documentation:** See individual command files in `.claude/commands/`
- **Examples:** Check the `examples/` directory (if available)
- **Issues:** Report bugs or request features through your platform's issue tracker

## Version History

### v1.0.0 (2025-11-13)
- Initial release
- Five-phase workflow (reproduce, analyze, fix, test, verify)
- Three agent personas (debugger-alex, tester-sam, reviewer-jordan)
- Comprehensive documentation and templates
- Deployment readiness checks and checklists

## Acknowledgments

Built with Claude Code, inspired by systematic debugging methodologies and industry best practices in software quality assurance.

---

**Ready to squash some bugs?** Start with `/reproduce` and let the workflow guide you through a systematic, thorough bug resolution process!
