## Project: main

**INFO**: Autodetected 1 Terraform project across 1 root module  
**INFO**: Found Terraform project main at directory .

### Monthly Costs

| Name | Monthly Qty | Unit | Monthly Cost |
|------|-------------|------|--------------|
| **azurerm_windows_virtual_machine.example** | | | |
| ├─ Instance usage (Windows, pay as you go, Standard_F2) | 730 | hours | $150.38 |
| └─ os_disk | | | |
|     ├─ Storage (S4, LRS) | 1 | months | $1.54 |
|     └─ Disk operations | 100,000 | 10k operations | $50.00 * |
| **azurerm_linux_virtual_machine.example** | | | |
| ├─ Instance usage (Linux, pay as you go, Standard_F2) | 730 | hours | $83.22 |
| └─ os_disk | | | |
|     ├─ Storage (S4, LRS) | 1 | months | $1.54 |
|     └─ Disk operations | 100,000 | 10k operations | $50.00 * |
| **azurerm_public_ip.acceptanceTestPublicIp2** | | | |
| └─ IP address (static, regional) | 730 | hours | $2.63 |
| **azurerm_public_ip.example** | | | |
| └─ IP address (static, regional) | 730 | hours | $2.63 |

**OVERALL TOTAL**: $341.93

*Usage costs were estimated using Infracost Cloud settings, see docs for other options.

---

11 cloud resources were detected:
- 4 were estimated
- 6 were free
- 1 is not supported yet, see Infracost requested resources:
  - 1 x `azurerm_spring_cloud_service`

---

### Cost Summary

| Project | Baseline cost | Usage cost* | Total cost |
|---------|---------------|-------------|------------|
| main | $242 | $100 | $342 |