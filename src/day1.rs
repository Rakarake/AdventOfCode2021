// -- Day 1 --

use std::fs;

pub fn main() {
    //// Just me getting used to rust
    //println!("super module 1 day one yes!");
    //let list: [i32; 4] = [1,2,3,4];
    //for item in list {
    //    println!("{}", item);
    //}
    //println!("{}", list.len());
    ////println!("Super text: {}", contents);


    // Doing it with a simple approach the first day
    let contents = fs::read_to_string("src/day1-input").expect("Sorry file does not exist");
    //let content_texts = contents.split(|c| (c == '\n'));
    {
        println!("-- Day1 | Part A --");
        let mut acc = 0;
        let mut previous = i32::MAX;

        for text in contents.split(|c| (c == '\n')) {
            if text == "" {
                break;
            }
            let value: i32 = text.parse::<i32>().unwrap();
            if value > previous {
                acc += 1;
            }
            previous = value;
        }
        println!("{}", acc);
    }

    //{
    //    println!("-- Day1 | Part B --");
    //    let mut acc = 0;
    //    let mut previous = i32::MAX;

    //    for i in 0..content_texts.char_indices().count() {
    //        if text == "" {
    //            break;
    //        }
    //        let value: i32 = text.parse::<i32>().unwrap();
    //        if value > previous {
    //            acc += 1;
    //        }
    //        previous = value;
    //    }
    //    println!("{}", acc);
    //}
}

