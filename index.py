import pandas as pd
from functools import reduce


# Kelas Learner untuk menyimpan maklumat setiap learner
class Learner:

    # Constructor untuk menetapkan maklumat learner
    def __init__(self, learner_id, name, completed_modules, scores):
        self.learner_id = learner_id
        self.name = name
        self.completed_modules = completed_modules
        self.scores = scores

        # Validasi skor supaya berada antara 0 hingga 100
        for score in scores:
            if not isinstance(score, (int, float)):
                raise ValueError("Scores must be numbers.")

            if score < 0 or score > 100:
                raise ValueError("Scores must be between 0 and 100.")

    # Function untuk mengira purata skor
    def calculate_average(self):
        return sum(self.scores) / len(self.scores)

    # Function untuk mengelaskan prestasi learner
    def classify_performance(self):
        average = self.calculate_average()

        if average >= 80:
            return "Excellent"
        elif average >= 70:
            return "Good"
        elif average >= 50:
            return "Pass"
        else:
            return "Needs Improvement"

    # Function untuk memaparkan maklumat learner
    def display_details(self):
        print(f"Learner ID: {self.learner_id}")
        print(f"Name: {self.name}")
        print(f"Completed Modules: {', '.join(self.completed_modules)}")
        print(f"Scores: {self.scores}")
        print(f"Average: {self.calculate_average():.2f}")
        print(f"Performance: {self.classify_performance()}")
        print()


# Senarai module
modules = [
    "Python",
    "Database",
    "Web Development",
    "Networking"
]


# Membina 5 objek learner
learners = [
    Learner("L001", "Leman", modules, [78, 85, 90]),
    Learner("L002", "Wan", modules, [88, 92, 84]),
    Learner("L003", "Ahmad", modules, [70, 75, 72]),
    Learner("L004", "Ali", modules, [95, 90, 93]),
    Learner("L005", "Abu", modules, [60, 65, 58])
]

print("========================================")
print("LEARNER DETAILS")
print("========================================")

for learner in learners:
    learner.display_details()

# map() digunakan untuk mendapatkan average setiap learner
averages = list(map(
    lambda learner: learner.calculate_average(),
    learners
))

print("========================================")
print("AVERAGES USING MAP()")
print("========================================")

for learner, average in zip(learners, averages):
    print(f"{learner.name}: {average:.2f}")


# filter() digunakan untuk mencari learner
# yang mempunyai average 70 atau lebih
high_performers = list(filter(
    lambda learner: learner.calculate_average() >= 70,
    learners
))

print()
print("========================================")
print("HIGH PERFORMERS USING FILTER()")
print("========================================")

for learner in high_performers:
    print(f"{learner.name}: {learner.calculate_average():.2f}")


# Lambda digunakan untuk sorting learner
ranking = sorted(
    learners,
    key=lambda learner: learner.calculate_average(),
    reverse=True
)

print()
print("========================================")
print("LEARNER RANKING USING LAMBDA")
print("========================================")

for position, learner in enumerate(ranking, start=1):
    print(
        f"{position}. {learner.name}: "
        f"{learner.calculate_average():.2f}"
    )


# List comprehension digunakan untuk mendapatkan
# nama semua learner
learner_names = [
    learner.name for learner in learners
]

print()
print("========================================")
print("LEARNER NAMES USING LIST COMPREHENSION")
print("========================================")

print(learner_names)


# reduce() digunakan untuk mendapatkan jumlah
# semua average learner
total_average = reduce(
    lambda total, average: total + average,
    averages
)

overall_average = total_average / len(averages)

print()
print("========================================")
print("OVERALL AVERAGE USING REDUCE()")
print("========================================")

print(f"Overall Average: {overall_average:.2f}")

# Data disusun untuk dimasukkan ke dalam DataFrame
data = []

for learner in learners:
    data.append({
        "Learner ID": learner.learner_id,
        "Name": learner.name,
        "Modules": len(learner.completed_modules),
        "Average": round(learner.calculate_average(), 2),
        "Performance": learner.classify_performance()
    })


# Membina DataFrame menggunakan pandas
df = pd.DataFrame(data)

print()
print("========================================")
print("PANDAS SUMMARY TABLE")
print("========================================")

print(df.to_string(index=False))

print()
print("========================================")
print("PANDAS FILTERED RESULTS")
print("========================================")

filtered_df = df[df["Average"] >= 70]

print(filtered_df.to_string(index=False))

print()
print("========================================")
print("PANDAS RANKED RESULTS")
print("========================================")

ranked_df = df.sort_values(
    by="Average",
    ascending=False
)

print(ranked_df.to_string(index=False))

print()
print("========================================")
print("TEST CASES")
print("========================================")


# Test Case 1: Normal input
print("\nTest Case 1 - Normal Input")

test1 = Learner(
    "T001",
    "Test Normal",
    ["Python", "Database"],
    [80, 90]
)

print(f"Average: {test1.calculate_average():.2f}")
print(f"Performance: {test1.classify_performance()}")


# Test Case 2: Boundary input
print("\nTest Case 2 - Boundary Input")

test2 = Learner(
    "T002",
    "Test Boundary",
    ["Python", "Database"],
    [70, 70]
)

print(f"Average: {test2.calculate_average():.2f}")
print(f"Performance: {test2.classify_performance()}")


# Test Case 3: Invalid input
print("\nTest Case 3 - Invalid Input")

try:
    test3 = Learner(
        "T003",
        "Test Invalid",
        ["Python", "Database"],
        [80, 120]
    )

    print(f"Average: {test3.calculate_average():.2f}")

except ValueError as error:
    print(f"Invalid input handled correctly: {error}")


# Test Case 4: Low performance
print("\nTest Case 4 - Low Performance")

test4 = Learner(
    "T004",
    "Test Low",
    ["Python", "Database"],
    [30, 40]
)

print(f"Average: {test4.calculate_average():.2f}")
print(f"Performance: {test4.classify_performance()}")