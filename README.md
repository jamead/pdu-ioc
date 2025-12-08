
# ALS-U Built-to-Print Power Distribution Units (PDUs)

BTP PDUs control AC power to individual power supplies and monitor total AC current.  
All PDUs are UL508A-certified and manufactured in a UL508A facility.

There are **9 models** available in 2-output, 3-output, and 4-output configurations.

---

# 📦 PDU Model Overview

| Model | Description | Input | Outputs | Size |
|-------|-------------|--------|----------|-------|
| **6201** | PS AR PDU A — 1×50A + 1×25A | 208V-3φ | 2× (3φ) | 4U |
| **6301** | PS BTA PDU A — 1×40A + 2×20A | 208V-3φ | 3× (3φ) | 4U |
| **6302** | PS BTA PDU C — 2×25A + 1×20A | 480V-3φ | 3× (3φ) | 6U |
| **6401** | PS BTA PDU B — 1×30A + 3×20A | 208V-3φ | 4× (3φ) | 4U |
| **6402** | PS AR PDU B — 4×20A | 480V-3φ | 4× (3φ) | 6U |
| **6303** | PS ATS STA PDU A — 3×20A | 208V-3φ | 3× (3φ) | 4U |
| **6403** | PS SR PDU A — 4×15A | 208V-3φ | 4× (2φ) | 4U |
| **6404** | PS SR PDU B — 4×20A | 208V-3φ | 4× (3φ) | 4U |
| **6405** | PS SR PDU C — 2×20A + 2×25A | 208V-3φ | 4× (3φ) | 4U |

---

# 🔵 Front Panel Layout

```
+-----------------------------------------------------------+
| [ MAIN BREAKER ]   [ CONTROL POWER ]                      |
|                                                           |
|  CH1 Breaker   CH2 Breaker   CH3 Breaker   CH4 Breaker    |
|                                                           |
|  J3: Ethernet (UDP)     J4: Programming                   |
|  J2: Front Panel Control Connector                        |
|                                                           |
|  UPA: Universal Power Alert (Input Power Indicator)       |
+-----------------------------------------------------------+
```

---

# 🟢 LCD Display Logic

**On boot:**
- Model  
- Serial Number  
- MAC Address  

**Normal display:**
- Input AC currents (A/B/C)  
- Front / Rear temperature  
- Channel ON/OFF state  
- Fault conditions  

---

# 🔶 Rear Panel Layout

```
+-----------------------------------------------------------+
|  OUTPUT 1   (with UPA)   |  OUTPUT 2   (with UPA)         |
|  OUTPUT 3   (with UPA)   |  OUTPUT 4   (with UPA)         |
|                                                             |
|                J1: Rear Panel Control Connector             |
+-------------------------------------------------------------+
```

---

# 🌐 UDP Communication Overview

Startup behavior:

```
1. Attempt DHCP for 60 seconds
2. If no address → fallback to default static IP: 10.4.24.108
```

---

# 🟦 UDP Command Table

| Command | Description |
|---------|-------------|
| `Status` | Return 20×4-byte words of device status |
| `CH1-ON`, `CH1-OFF` | Control Output 1 |
| `CH2-ON`, `CH2-OFF` | Control Output 2 |
| `CH3-ON`, `CH3-OFF` | Control Output 3 |
| `CH4-ON`, `CH4-OFF` | Control Output 4 |
| `ALL-ON` | Enable all output channels |
| `ALL-OFF` | Disable all output channels |
| `ChMacAddxxxxxxxxxxxx` | Overwrite MAC address (reboot required) |

---

# 📡 Status Frame (20 Words)

| Index | Name | Type | Description |
|-------|------|------|-------------|
| 0 | Frame Start | Float | Always **1000** |
| 1 | Current Phase A | Float | 0–99 A |
| 2 | Current Phase B | Float | 0–99 A |
| 3 | Current Phase C | Float | 0–99 A |
| 4 | CH1 Status | Float | Status register |
| 5 | CH2 Status | Float | Status register |
| 6 | CH3 Status | Float | Status register |
| 7 | CH4 Status | Float | Status register |
| 8–9 | — | — | Not used |
| 10 | Front Temp | Float | °C |
| 11 | Rear Temp | Float | °C |
| 12 | Serial Number | Float | — |
| 13 | Model | Float | Last 4 digits |
| 14 | Firmware | Float | Version |
| 15–17 | — | — | Not used |
| 18 | WDT Flag | Int | `1 = Hardware WDT tripped` |
| 19 | Frame End | Float | Always **1001** |

---

# 🧩 Channel Status Register

```
31                         8 7 6 5 4 3 2 1 0
+---------------------------+-------------+
|         Reserved          | h g f e d c b a |
+---------------------------+-------------+
```

| Bit | Meaning | Description |
|-----|---------|-------------|
| a | Network Command | Set by network at boot |
| b | Front Panel Command | Local front-panel pushbutton |
| c | Rear Panel Signal | Good/Bad |
| d | Relay | Output voltage monitor |
| e | Aux Contactor | Output ON |
| f | — | Always 0 |
| g | — | Always 0 |
| h | — | Always 0 |

---

# 📊 Example Status Response

```
Index 0: 1000.0
Index 1: 45.1
Index 2: 45.6
Index 3: 45.8
Index 4: 31.0
Index 5: 31.0
Index 6: 31.0
Index 7: 0.0
Index 8: 0.0
Index 9: 0.0
Index 10: 30.0
Index 11: 30.0
Index 12: 10.0
Index 13: 6302.0
Index 14: 1.0
Index 15: 0.0
Index 16: 0.0
Index 17: 0.0
Index 18: 0.0
Index 19: 1001.0
```
