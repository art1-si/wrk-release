class ExerciseJson {
  static const exercises = """
  [
    {
        "exerciseName": "Cable Crossover",
        "exerciseType": "Chest",
        "id": "1"
    },
    {
        "exerciseName": "Decline Barbell Bench Press",
        "exerciseType": "Chest",
        "id": "2"
    },
    {
        "exerciseName": "Flat Barbell Bench Press",
        "exerciseType": "Chest",
        "id": "3"
    },
    {
        "exerciseName": "Flat Dumbbell Bench Press",
        "exerciseType": "Chest",
        "id": "4"
    },
    {
        "exerciseName": "Flat Dumbbell Fly",
        "exerciseType": "Chest",
        "id": "5"
    },
    {
        "exerciseName": "High to Low Cable Fly",
        "exerciseType": "Chest",
        "id": "6"
    },
    {
        "exerciseName": "Incline Barbell Bench Press",
        "exerciseType": "Chest",
        "id": "7"
    },
    {
        "exerciseName": "Incline Dumbbell Bench Press",
        "exerciseType": "Chest",
        "id": "8"
    },
    {
        "exerciseName": "Incline Dumbbell Fly",
        "exerciseType": "Chest",
        "id": "9"
    },
    {
        "exerciseName": "Barbell Row",
        "exerciseType": "Back",
        "id": "10"
    },
    {
        "exerciseName": "Chin up",
        "exerciseType": "Back",
        "id": "11"
    },
    {
        "exerciseName": "Deadlift",
        "exerciseType": "Back",
        "id": "12"
    },
    {
        "exerciseName": "Barbell Shrug",
        "exerciseType": "Back",
        "id": "13"
    },
    {
        "exerciseName": "Dumbbell Row",
        "exerciseType": "Back",
        "id": "14"
    },
    {
        "exerciseName": "Lat Pulldown",
        "exerciseType": "Back",
        "id": "15"
    },
    {
        "exerciseName": "Pull up",
        "exerciseType": "Back",
        "id": "16"
    },
    {
        "exerciseName": "Rack Pull",
        "exerciseType": "Back",
        "id": "17"
    },
    {
        "exerciseName": "Seated Cable Row",
        "exerciseType": "Back",
        "id": "18"
    },
    {
        "exerciseName": "T-Bar Row",
        "exerciseType": "Back",
        "id": "19"
    },
    {
        "exerciseName": "Barbell Curl",
        "exerciseType": "Bicep",
        "id": "20"
    },
    {
        "exerciseName": "Cable Curl",
        "exerciseType": "Bicep",
        "id": "21"
    },
    {
        "exerciseName": "Dumbbell Concentration Curl",
        "exerciseType": "Bicep",
        "id": "22"
    },
    {
        "exerciseName": "Dumbbell Curl",
        "exerciseType": "Bicep",
        "id": "23"
    },
    {
        "exerciseName": "Dumbbell Hammer Curl",
        "exerciseType": "Bicep",
        "id": "24"
    },
    {
        "exerciseName": "Dumbbell Preacher Curl",
        "exerciseType": "Bicep",
        "id": "25"
    },
    {
        "exerciseName": "EZ-Bar Curl",
        "exerciseType": "Bicep",
        "id": "26"
    },
    {
        "exerciseName": "EZ-Bar Preacher Curl",
        "exerciseType": "Bicep",
        "id": "27"
    },
    {
        "exerciseName": "Reverse EZ-Bar Curl",
        "exerciseType": "Bicep",
        "id": "28"
    },
    {
        "exerciseName": "Seated Incline Dumbbell Curl",
        "exerciseType": "Bicep",
        "id": "29"
    },
    {
        "exerciseName": "Cable Overhead Triceps Extension",
        "exerciseType": "Tricep",
        "id": "30"
    },
    {
        "exerciseName": "Close Grip Barbell Bench Press",
        "exerciseType": "Tricep",
        "id": "31"
    },
    {
        "exerciseName": "Dumbbel Overhead Triceps Extension",
        "exerciseType": "Tricep",
        "id": "32"
    },
    {
        "exerciseName": "EZ-Bar Skullcrusher",
        "exerciseType": "Tricep",
        "id": "33"
    },
    {
        "exerciseName": "Lying Triceps Extension",
        "exerciseType": "Tricep",
        "id": "34"
    },
    {
        "exerciseName": "Rope Push Down",
        "exerciseType": "Tricep",
        "id": "35"
    },
    {
        "exerciseName": "V-Bar Push Down",
        "exerciseType": "Tricep",
        "id": "36"
    },
    {
        "exerciseName": "Arnold Dumbell Press",
        "exerciseType": "Shoulders",
        "id": "37"
    },
    {
        "exerciseName": "Cable Face Pull",
        "exerciseType": "Shoulders",
        "id": "38"
    },
    {
        "exerciseName": "Front Dumbbell Raise",
        "exerciseType": "Shoulders",
        "id": "39"
    },
    {
        "exerciseName": "Lateral Dumbbell Raise",
        "exerciseType": "Shoulders",
        "id": "40"
    },
    {
        "exerciseName": "Lateral Machine Raise",
        "exerciseType": "Shoulders",
        "id": "41"
    },
    {
        "exerciseName": "Lying Face Pulls",
        "exerciseType": "Shoulders",
        "id": "42"
    },
    {
        "exerciseName": "Overhead Press",
        "exerciseType": "Shoulders",
        "id": "43"
    },
    {
        "exerciseName": "Rear Delt Machine Fly",
        "exerciseType": "Shoulders",
        "id": "44"
    },
    {
        "exerciseName": "Seated Dumbbell Lateral Raise",
        "exerciseType": "Shoulders",
        "id": "45"
    },
    {
        "exerciseName": "Seated Dumbbell Press",
        "exerciseType": "Shoulders",
        "id": "46"
    },
    {
        "exerciseName": "Barbell Squat",
        "exerciseType": "Legs",
        "id": "47"
    },
    {
        "exerciseName": "Barbell Calf Raise",
        "exerciseType": "Legs",
        "id": "48"
    },
    {
        "exerciseName": "Barbell Front Squat",
        "exerciseType": "Legs",
        "id": "49"
    },
    {
        "exerciseName": "Barbell Glute Bridge",
        "exerciseType": "Legs",
        "id": "50"
    },
    {
        "exerciseName": "Barbell Walking Lunge",
        "exerciseType": "Legs",
        "id": "51"
    },
    {
        "exerciseName": "Dumbbell Walking Lunge",
        "exerciseType": "Legs",
        "id": "52"
    },
    {
        "exerciseName": "Bulgarian Split Squat",
        "exerciseType": "Legs",
        "id": "53"
    },
    {
        "exerciseName": "Donkey Calf Raise",
        "exerciseType": "Legs",
        "id": "54"
    },
    {
        "exerciseName": "Glute-Ham Raise",
        "exerciseType": "Legs",
        "id": "55"
    },
    {
        "exerciseName": "Leg Extension Machine",
        "exerciseType": "Legs",
        "id": "56"
    },
    {
        "exerciseName": "Lying Leg Curl Machine",
        "exerciseType": "Legs",
        "id": "57"
    },
    {
        "exerciseName": "Leg Press",
        "exerciseType": "Legs",
        "id": "58"
    },
    {
        "exerciseName": "Leg Press Calf Raise",
        "exerciseType": "Legs",
        "id": "59"
    },
    {
        "exerciseName": "Seated Calf Raise Machine",
        "exerciseType": "Legs",
        "id": "60"
    },
    {
        "exerciseName": "Romanian Deadlift",
        "exerciseType": "Legs",
        "id": "61"
    },
    {
        "exerciseName": "Smith Machine Calf Raise",
        "exerciseType": "Legs",
        "id": "62"
    },
    {
        "exerciseName": "Sumo Deadlift",
        "exerciseType": "Legs",
        "id": "63"
    }
]
  """;
}
