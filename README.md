# 🌙 تطبيق إسلامي | Islam App

تطبيق إسلامي متكامل وشامل ومبني باستخدام إطار العمل **Flutter** مع اتباع أفضل الممارسات والمعماريات البرمجية الحديثة (**Clean Architecture** مع **Bloc/Cubit**). يهدف التطبيق إلى توفير تجربة مستخدم سلسة ومريحة للمسلم في حياته اليومية.

---

## ✨ المميزات الرئيسية (Features)

* 📖 **القرآن الكريم (Holy Quran)**:
  * عرض سور القرآن الكريم مع تفاصيل كل سورة (مكية / مدنية، عدد الآيات).
  * حفظ تلقائي لآخِر سورة وموضع قراءة لمتابعة القراءة بسهولة باستخدام **Hive**.
  * تصميم واجهة مريح ومناسب للقراءة.

* 📿 **المسبحة الإلكترونية (Digital Tasbih)**:
  * عداد تسبيح تفاعلي مع مؤثرات بصرية متميزة (دوران المسبحة وتغير الألوان عند إتمام الهدف).
  * نظام التنبيه بالاهتزاز (**Haptic Feedback**): اهتزاز خفيف أثناء التسبيح واهتزاز قوي وممتد بنبضات متتالية عند الوصول للهدف.
  * دعم أذكار تسبيح متنوعة مع إمكانية التنقل بينها بسهولة.

* 🤲 **الأذكار (Athkar)**:
  * تشمل أذكار الصباح، أذكار المساء، أذكار بعد الصلاة، أذكار الاستيقاظ، وأذكار النوم.
  * عداد تفاعلي لكل ذكر لضبط التكرار المطلوب.

* 🕌 **مواقيت الصلاة (Prayer Times)**:
  * تحديد مواقيت الصلاة الدقيقة حسب الموقع الجغرافي للمستخدم باستخدام مكتبتي `adhan` و `location`.
  * عرض التاريخ الهجري والميلادي والوقت المتبقي للصلاة القادمة.

* 📜 **الأحاديث النبوية (Hadith)**:
  * عرض الأربعين النووية مع شرح ومصدر كل حديث بتنسيق وأسلوب عرض جذاب.

* 📻 **الإذاعة الإسلامية (Islamic Radio & Audio)**:
  * الاستماع إلى إذاعات القرآن الكريم ومختلف القراء والمحطات الصوتية.
  * دعم التشغيل في الخلفية (**Background Audio Service**) للتحكم في الصوت عبر شاشة القفل والإشعارات.
  * قائمة المفضلة لإضافة وإدارة الإذاعات والقراء المفضلين.

---

## 🛠️ التقنيات والمعماريات البرمجية (Tech Stack & Best Practices)

### 🏗️ المعمارية ونمط البناء (Architecture & Design Patterns)
* **Clean Architecture (Feature-First Structure)**:
  تقسيم المشروع بناءً على الميزات (Features)، وتفصيل كل ميزة إلى 3 طبقات رئيسية (`Data`, `Domain/Repo`, `Presentation`) لضمان سهولة الصيانة وقابلية التوسع (Scalability) واختبار الكود (Testability).
* **Repository Design Pattern**:
  فصل مصدر البيانات (Local JSON / Cache / Remote API) عن واجهة المستخدم والـ Cubits عبر واجهات (Interfaces) ومستودعات خفيفة.

### ⚡ إدارة الحالة (State Management)
* **BLoC / Cubit Pattern (`flutter_bloc`)**:
  استخدام نمط Cubit لإدارة حالات التطبيقات بشكل نظيف وفصل منطق العمل (Business Logic) تماماً عن أودجات العرض (UI)، مع الاستفادة من `MultiBlocProvider` و `BlocBuilder`.

### 💾 التخزين المحلي وقواعد البيانات (Local Storage & Persistence)
* **Hive NoSQL Database (`hive_flutter`)**:
  قاعدة بيانات محلية سريعة وخفيفة جداً لحفظ تفضيلات المستخدم، مثل:
  - حفظ آخر سورة وموضع قراءة في القرآن الكريم تلقائياً.
  - قائمة الإذاعات والقراء المفضلة.


### 📻 تشغيل الصوتيات في الخلفية (Background Audio Streaming)
* **Just Audio & Audio Service (`just_audio` & `just_audio_background`)**:
  - بث وإدارة محطات الإذاعة والصوتيات بدقة عالية.
  - دعم تشغيل الصوت في خلفية النظام (**Background Audio Service**).
  - إظهار عناصر التحكم بالصوت (تشغيل، إيقاف، اسم القراءة) على **شاشة القفل (Lock Screen)** و**قائمة الإشعارات**.

### 📍 الجغرافيا ومواقيت الصلاة (Geolocation & Calculation)
* **Location API (`location`)**:
  جلب إحداثيات الموقع الجغرافي الدقيقة للمستخدم.
* **Adhan Library (`adhan`)**:
  حساب مواقيت الصلاة الفلكية تلقائياً بناءً على موقع المستخدم والمنطقة الزمنية وطريقة الحساب.

### 🧭 التنقل والروابط (Navigation & Routing)
* **GoRouter (`go_router`)**:
  إدارة التنقل في التطبيق بطريقة تصريحية (Declarative Routing) تسمح بالانتقال السلس وتمرير المعاملات (Parameters) وإدارة شجرة التنقل بنظافة.

### 🛡️ المعالجة الآمنة للأخطاء (Functional Programming & Error Handling)
* **Dartz Package (`dartz`)**:
  تطبيق مبادئ البرمجة الوظيفية باستخدام `Either<Failure, Success>` لضمان معالجة الأخطاء والـ Exceptions بأسلوب آمن ودون توقف التطبيق أو حدوث Crashes.

### 🌐 الشبكات واستهلاك الـ APIs (Networking)
* **Dio HTTP Client (`dio`)**:
  استهلاك الخدمات والبيانات من الإنترنت مع دعم الـ Interceptors والتحكم في مهلة الاتصال (Timeouts) ومعالجة الأخطاء الشبكية.

### 📱 تفاعل وتجاوب واجهة المستخدم (UI/UX & Native Features)
* **Haptic Feedback API**:
  تقديم استجابة لمسية (اهتزازات مخصصة ونبضات متتالية) عند التفاعل مع المسبحة الإلكترونية.
* **Custom Responsive Design**:
  تنسيق واجهات مستخدم مخصصة بالكامل تدعم مختلف أحجام الشاشات، الوضع الليلي (Dark Theme)، واللغة العربية (RTL Direction) مع ضبط التواريخ الهجرية والميلادية (`intl` & `hijri`).

---

## 📂 هيكل المشروع (Project Structure)

```text
lib/
├── core/                       # الملفات المبتذلة والأدوات العامة (Utilities, Errors, Router, Styles)
│   ├── errors/                 # معالجة الأخطاء الاستثنائية
│   └── util/                   # الراوتر، الأنماط، والودجات المشتركة
└── features/                   # الميزات الرئيسية للتطبيق
    └── home/
        ├── data/               # طبقة البيانات (Models & Repositories Implementations)
        │   ├── models/         # نماذج البيانات (Quran, Athkar, Hadith, Radio, Tasbih)
        │   └── repo/           # مستودعات جلب البيانات
        ├── presentation/       # طبقة العرض وإدارة الحالة
        │   ├── manger/         # ملفات الـ Cubit لكل ميزة
        │   └── view/           # الشاشات والـ Widgets الفرعية
        │       └── widgets/
        │           ├── quran_view/
        │           ├── time_view/
        │           ├── hadith_view/
        │           ├── radio_view/
        │           └── tasbih_view/
        └── ...
```

---

## 🚀 كيفية تشغيل المشروع (Getting Started)

### الشروط الأساسية (Prerequisites):
* تثبيت **Flutter SDK** (إصدار 3.10.1 أو أحدث).
* تثبيت **Android Studio** أو **VS Code** مع إضافات Flutter/Dart.

### الخطوات:

1. **استنساخ المستودع (Clone repository)**:
   ```bash
   git clone https://github.com/username/islam_app.git
   cd islam_app
   ```

2. **تثبيت حزم ومكتبات المشروع (Install dependencies)**:
   ```bash
   flutter pub get
   ```

3. **تشغيل التطبيق (Run application)**:
   ```bash
   flutter run
   ```

---

## 📱 إعدادات منصة أندرويد (Android Permissions)

يتضمن التطبيق إعدادات خاصة بتشغيل الصوت في الخلفية وتحديد الموقع:
* `ACCESS_FINE_LOCATION` و `ACCESS_COARSE_LOCATION` لحساب مواقيت الصلاة.
* `FOREGROUND_SERVICE` و `FOREGROUND_SERVICE_MEDIA_PLAYBACK` لتشغيل الإذاعة في الخلفية.
* إعداد خدمة `AudioService` في ملف `AndroidManifest.xml`.

---

## 📄 الترخيص (License)

هذا المشروع متاح للاستخدام المفتوح والمجاني كصدقة جارية. نسأل الله أن ينفع به الجميع.

---
⭐ **لا تنسَ إعطاء المستودع نجمة إذا أعجبك المشروع!**
