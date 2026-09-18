# Home Assistant Real-World Testbed & Concurrency Standards

## 1. Real-World Home Assistant Testbed Strategy
All in-house libraries developed across the Wols CA ecosystem must be integrated and verified within **Home Assistant**.

### Core Requirements:
1. **Meaningful Added Value for Users**:
   - Testbed implementations must not be sterile mocks or artificial loops; they must deliver **genuine utility to real Home Assistant users**.
   - Examples:
     - `Wols_CA_HA_Eufy`: Comprehensive integration of security cameras, motion sensors, two-way audio, and real-time alarm system triggers.
     - `Wols_CA_ElectricPowerConsumption`: Real-time energy telemetry, smart metering, and grid load monitoring.
     - `Wols_CA_M2M_Lib`: High-security Zero-Trust communication between field sensors, cameras, and central Home Assistant instances.
2. **Broad Community Field Testing**:
   - Packaging libraries into productive Home Assistant add-ons and custom integrations provides continuous real-world stress testing across diverse hardware (x86_64, Raspberry Pi ARM64, Alpine Linux containers) and variable network conditions.

---

## 2. Event-Driven Software Architecture
- **Strictly Event-Driven**:
  - Components react to discrete events (e.g., incoming network packets, MQTT messages, hardware triggers, state transitions, or scheduled event triggers).
  - Synchronous blocking waits for remote responses are strictly prohibited.
- **NO OS-Level Timers**:
  - Do not use OS system timers (such as `SetTimer`, `alarm()`, or timer threads that invoke asynchronous signal handlers).
  - Event generation and frequency-based checks (e.g., periodic health checks, key rotation, URL hopping) are driven by **deterministic, second-accurate event loops** that compare explicit target timestamps (`LastEvent`, `NextEvent`) against current system time and persist state to the database.

---

## 3. Mandatory Multi-Threading & Concurrency Model
- **Always Multi-Threaded**:
  - Every long-running process, service runner, uploader, watcher, and event generator executes in its own **dedicated OS worker thread**.
  - No background task may block the main application loop, UI thread, or Home Assistant coordinator thread.
- **Thread Roles & Separation**:
  - **Uploader / Worker Threads**: Handle network I/O and protocol handshakes.
  - **Watcher / Guard Threads**: Continuously monitor execution deadlines and fail-fast timeouts using property sheets.
  - **Event Generator Threads**: Deterministically evaluate and fire scheduled events.
- **Safe Thread Synchronization**:
  - Use thread-safe lock-free queues, atomic variables (`std::atomic`), and condition variables (`std::condition_variable`) for inter-thread communication.
