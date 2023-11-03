input_file = "a2_response.txt"
output_prefix = "answers_"

with open(input_file, "r") as file:
    paragraphs = file.read().split("\n\n")

for i, paragraph in enumerate(paragraphs):
    output_file = f"{output_prefix}{i+1}.txt"
    with open(output_file, "w") as file:
        file.write(paragraph)
        print(f"Paragraph {i+1} written to {output_file}")