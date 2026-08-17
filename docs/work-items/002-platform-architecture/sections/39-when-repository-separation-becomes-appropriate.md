# 39. When Repository Separation Becomes Appropriate

Consider extracting a component when several of these become true:

- [ ] independent release lifecycle
- [ ] independent ownership/team
- [ ] independent access/security requirements
- [ ] independent public/private visibility requirements
- [ ] substantially different CI/CD lifecycle
- [ ] independent versioning becomes operationally valuable
- [ ] repository size materially harms development workflows
- [ ] consumers require released versions independent of platform development
- [ ] component becomes reusable across multiple unrelated products/platforms

Do not extract merely because:

- [ ] it uses another language
- [ ] it has its own Dockerfile
- [ ] it deploys independently
- [ ] it has its own database
- [ ] it is called a "microservice"
