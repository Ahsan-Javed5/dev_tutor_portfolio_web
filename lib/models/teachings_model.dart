class TeachingModel {
  final String title;
  final List<String> descriptionList;
  final String? buttonText;

  TeachingModel({
    required this.title,
    required this.descriptionList,
    this.buttonText,
  });

  static List<TeachingModel> teachings = [
    TeachingModel(
      title: "Teaching Overview",
      descriptionList: [
        "🎓 50+ Students Taught Internationally",
        "🌍 UK, USA, UAE, Pakistan Coverage",
        "📐 Mathematics | 💻 Computer Science | 🤖 AI Tutoring",
        "🏫 School to Early University Level",
        "📊 Concept Clarity + Exam Preparation Focus"
      ],
    ),
    TeachingModel(
      title: "Curriculum Coverage",
      descriptionList: [
        "🇬🇧 UK (A-Level / GCSE Standards)",
        "🇺🇸 USA High School & Intro College",
        "🇦🇪 UAE / Gulf (British & CBSE System)",
        "🇵🇰 Pakistan Intermediate & University Prep",
        "📘 Concept + Exam-Oriented Learning"
      ],
    ),
    TeachingModel(
      title: "Subjects",
      descriptionList: [
        "📐 Calculus I & II",
        "📊 Statistics & Probability",
        "🧮 Mathematical Methods",
        "➗ Linear Algebra Basics",
        "💻 Programming (Python / C++)",
        "🧠 Data Structures & Algorithms",
        "🤖 Artificial Intelligence Basics",
        "📈 Machine Learning Fundamentals",
        "🧬 Deep Learning Introduction",
        "🖥️ Computing Theory"
      ],
    ),
    TeachingModel(title: "Teaching Modes", descriptionList: [
      "👤 1-to-1 Tutoring",
      "👥 Group Classes",
      "📚 Project-Based Learning",
      "🎯 SAT / Entry Test Preparation"
    ]),
    TeachingModel(title: "Learning Approach", descriptionList: [
      "🧩 Concept First Approach",
      "✍️ Practice & Problem Solving Focus",
      "⏱️ Exam-Oriented Preparation",
      "🧪 Real-World Applications",
      "🚀 Skill + Project Based Learning"
    ]),
  ];
}
