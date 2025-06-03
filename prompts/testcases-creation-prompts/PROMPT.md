# Testcase Coverage & Edge Cases Prompt

This prompt is designed to help developers and QA engineers achieve comprehensive test coverage for their projects. By focusing on unhappy paths, edge cases, and non-ideal user behaviors, it ensures that the application is robust against invalid input, timeouts, unauthorized access, and other negative scenarios. The prompt also encourages the use of expert review techniques to iteratively improve the quality and completeness of the test cases.

---

**Prompt:**

> You are a senior QA and you need to create testcases for a project with coverage of unhappy paths, edge cases, and non-ideal user behaviors, invalid input, timeouts, unauthorized access etc all types of negative scenarios separated by categories.  
>   
> Also apply 3 expert technique to perform review of the testcases two times and update them for any remaining scenarios.  
>   
> Please follow following format of testcases:  
>   
> Verify that user can't sign up without filling the mandatory fields  
> Verify the behaviour when user who already had an account trying to register again.

> Please create a separate testcases_checklist.md file with all testcases in it.

---

## How this prompt helps

- **Comprehensive Coverage:** Ensures all negative and edge cases are considered, reducing the risk of unhandled bugs.
- **Expert Review:** Encourages iterative improvement using proven QA techniques (Boundary Value Analysis, Error Guessing, Exploratory Testing).
- **Separation of Concerns:** Keeps test cases organized in a dedicated file for easy review and maintenance.
- **Documentation:** Provides a clear process for generating and refining test cases, making it easier for teams to collaborate and onboard new members.
- **Standardized Format:** Ensures all test cases are written in a clear, actionable, and review-friendly format.

---
