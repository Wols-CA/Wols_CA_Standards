# Wols CA Zero-Trust Architecture & System Topology

> **Normative reference**: every design decision in this document must also satisfy the ten general architecture principles (consequent, orthogonality, singularity, thrift, completeness, balance, transparent, generality, openness, scalability) defined in `Architecture_General_IT_Principles.md`.

## 1. Zero-Trust Security Foundation
The Wols CA ecosystem operates on a strict **Zero-Trust Network Architecture**:
- **Never Trust, Always Verify**: Every participant, connection, and telemetry stream must authenticate explicitly.
- **Fail-Fast Protocol**: Handshake messages over MQTT are non-retained (`retained = false`). On packet drops or timeouts, no recovery is attempted; state resets immediately to step 0.
- **Defense-in-Depth**: Outer TLS 1.3 transport shielding (wolfSSL or OpenSSL) combined with inner End-to-End Zero-Trust payload encryption (AES-256-GCM / RSA / FIDO2 WorkPermits).

---

## 2. 5-Tier Uploader Model & Network Zoning
1. **First Contact Uploader (Layer 4 - Public Internet)**:
   - WebService with deterministic hourly URL-rotation (`/api/v1/{hash}`).
   - Validates DNA-based TOTP, salted partial DNA proofs, and ephemeral public keys (61-minute max validity).
   - Deception cycle with randomized fake challenges prior to valid secret exchange. Expired keys routed to "The Maze" (tarpit).
2. **Hello Uploader (Layer 1 - Public Internet)**:
   - Ingress endpoint for Windows Hello / FIDO2 WorkPermits issued by `SecureLaptop`.
3. **Logon Uploader (Layer 2 - Protected DMZ)**:
   - Handles credential authentication and dynamic MQTT broker handoff directives.
4. **Production Uploader (Layer 3 - High Security / Cloud Secure Cell)**:
   - Dedicated high-security broker handling active operational telemetry.
   - Dual-Channel Model: Low-bandwidth MQTT control channel + High-bandwidth streaming data channel.
   - Periodic in-flight DNA-TOTP re-authentication (*"Am I still me?"*).
   - Zero-Footprint Dynamic Workload Injection: Injects operational binaries directly into node RAM (no persistent storage).
5. **Admin Uploader (Central Web Spider)**:
   - Governs key generation, pre-staged encryption key pools, PRNG Shannon entropy statistics, certificate population, and rapid housekeeping.
   - Communicates with uploaders strictly via lock-free in-memory queues and a crash-resilient database (no MQTT).

---

## 3. Cloud Secure Cell Architecture
- **Tri-Block Isolation**:
  - **Interface Block**: Outbound-only proxies, reverse relays, and ingress brokers.
  - **Service Block**: Stateless uploaders and business logic processors.
  - **Data Block**: Double-encrypted persistent storage (database encryption + volume storage encryption).
- **Outbound Connections Only**: Internal services never expose open listening ports to DMZ or internet.
- **Ephemeral Node Lifecycles**: Application servers can be continuously replaced with zero data loss.
