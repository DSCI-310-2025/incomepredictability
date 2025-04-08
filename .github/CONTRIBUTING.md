# Contributing to `incomepredictability`

Thank you for your interest in contributing to the `incomepredictability` R package! We welcome and appreciate all kinds of contributions, from reporting bugs and requesting features to improving documentation and submitting code.

## Code of Conduct

By participating in this project, you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). Please read it before contributing.

## How to Contribute

### Reporting Issues or Suggesting Features
- Check existing issues before opening a new one.
- Provide a clear description, steps to reproduce (if applicable), and any relevant context.

### Contributing Code
1. **Fork** this repository and **clone** your fork locally.
2. Create a new **branch** (`feature/your-feature-name` or `fix/your-bug-name`).
3. Make your changes, keeping commits focused and descriptive.
4. Run `devtools::test()` to ensure all tests pass.
5. Run `devtools::document()` to update documentation if needed.
6. Submit a **Pull Request (PR)** with a clear explanation of the changes and why they are useful.

## Testing

Please write tests for new functions using the `{testthat}` package. Your code should pass all existing tests and include new ones where appropriate.

## Team Workflow

- All work happens via GitHub PRs.
- Reviewers will provide feedback within **7 days**.
- Use [GitHub Actions](.github/workflows/) to ensure CI checks pass before requesting review.

## Style Guide

- Follow the [tidyverse style guide](https://style.tidyverse.org).
- Export only functions meant for users.
- Include roxygen2 documentation and examples with every exported function.

## Need Help?

If you’re stuck or have questions, open an issue and tag the maintainers. We're happy to help!

---

Happy coding and thank you for helping make `incomepredictability` better!