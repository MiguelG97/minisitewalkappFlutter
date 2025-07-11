# 🏗️ Site Inspection App – Flutter Application (iPad-Optimized)

A powerful **Flutter-based** application tailored specifically for **iPad devices**, built for the **AEC (Architecture, Engineering, and Construction)** industry. This digital twin platform allows field engineers and inspectors to conduct **site walk inspections** and **validate real-world conditions** against the corresponding **3D design models**.

---

## 📱 Demo (Built for iPad)

> 🛠️ **Optimized for iPad** to support on-site workflows with a spacious, touch-first interface — ideal for carrying out inspections in the field while referencing large BIM models in real time.

> 📂 To preview the app in action, watch the demo below:

https://github.com/user-attachments/assets/3e6bb3a9-6f4a-43f6-bc94-fe6f2bafc2e7

---
## 🔍 What It Does

This app bridges the gap between **design intent** and **on-site execution**:

- Compare what's **in situ** (physically present on-site) against the 3D design model  
- Inspect, tag, and document deviations directly from the field  
- Enable collaborative verification across teams  
- Record issues and observations linked to spatial context and model elements

---
## 📴 Offline-First Experience

✅ **No network? No problem.**

- 3D models are stored locally on the iPad
- Visualize, navigate, and inspect models without internet nor Autodesk Access tokens
- Continue recording site observations and sync later when online

---

## 📦 Supported 3D File Formats

- `.dwg` – Autodesk AutoCAD / Civil 3D files  
- `.rvt` – Autodesk Revit files

---
## 🚀 Getting Started

### Prerequisites

- Flutter 3.16+
- Dart 3.2+
- iPadOS 16+ (physical device or simulator via Xcode)
- Access to valid 3D model files (e.g. `.rvt`, `.dwg`)

---
### Build & Run

```bash
flutter pub get
flutter run -d [device_id]
