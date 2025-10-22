//
//  CategoryViewModel.swift
//  homezy
//
//  Created by Riccardo Puggioni on 16/10/25.
//

import Foundation
import SwiftUI

let categories: [Category] = [
    .init(
        name: "Kitchen",
        icon: "fork.knife",
        color: .orange,
        description: "Tips and tasks to keep your kitchen clean and organized.",
        tips: [
            .init(title: "Clean the stove", details: "1. Turn off the stove and let it cool down.\n2. Remove grates and detachable parts.\n3. Spray a degreaser and let it sit for 2–3 minutes.\n4. Scrub with a non-abrasive sponge, focusing on grease spots.\n5. Wipe clean with a damp cloth and dry with a towel.\n6. Reassemble all parts."),
            .init(title: "Wash the dishes", details: "1. Scrape off food leftovers.\n2. Fill the sink with hot, soapy water or load the dishwasher.\n3. Wash from least to most dirty items.\n4. Rinse with warm water.\n5. Dry or place on the drying rack.\n6. Wipe the sink area afterwards."),
            .init(title: "Wipe the counters", details: "1. Clear off crumbs and objects.\n2. Spray a disinfectant or all-purpose cleaner.\n3. Let it sit for a few seconds.\n4. Wipe with a microfiber cloth using circular motions.\n5. Rinse or wipe again with a damp cloth.\n6. Dry with a clean towel."),
            .init(title: "Empty the trash", details: "1. Tie the bag when it’s two-thirds full.\n2. Remove it carefully to avoid spillage.\n3. Insert a new liner and fold edges over the rim.\n4. Wash or disinfect the bin if needed.\n5. Take the trash out following recycling rules."),
            .init(title: "Clean the fridge", details: "1. Empty all food and remove expired items.\n2. Take out drawers and shelves and wash them.\n3. Wipe the interior with water and baking soda or mild soap.\n4. Dry thoroughly before replacing shelves.\n5. Reorganize items by type and expiration date."),
            .init(title: "Sweep the floor", details: "1. Move rugs or small furniture.\n2. Sweep or vacuum corners and edges first.\n3. Work toward the center of the room.\n4. Collect dirt into a dustpan.\n5. Mop if needed for extra shine."),
            .init(title: "Organize the pantry", details: "1. Empty shelves completely.\n2. Group food by type (cans, cereals, spices, etc.).\n3. Discard expired or unused products.\n4. Use transparent containers to keep items visible.\n5. Label sections for easy access."),
            .init(title: "Clean the sink", details: "1. Remove dishes and rinse the basin.\n2. Sprinkle baking soda or spray cleaner.\n3. Scrub with a sponge, especially around the drain.\n4. Use an old toothbrush for hard-to-reach areas.\n5. Rinse with hot water and dry with a towel."),
            .init(title: "Wipe handles", details: "1. Spray disinfectant on a cloth.\n2. Wipe fridge, cabinet, and drawer handles.\n3. Don’t forget light switches and door knobs.\n4. Let dry completely before touching."),
            .init(title: "Deep clean the oven", details: "1. Remove racks and trays.\n2. Apply oven cleaner or baking soda paste.\n3. Let it sit for several hours.\n4. Scrape residue gently and wipe with a sponge.\n5. Rinse with water and dry thoroughly.")
        ]
    ),
    .init(
        name: "Bathroom",
        icon: "shower",
        color: .blue,
        description: "Keep your bathroom fresh and sanitized.",
        tips: [
            .init(title: "Clean the sink", details: "1. Remove all items from the counter.\n2. Apply bathroom cleaner or baking soda and vinegar.\n3. Scrub with a sponge or brush.\n4. Rinse with hot water.\n5. Wipe dry for a shiny finish."),
            .init(title: "Disinfect the toilet", details: "1. Pour toilet cleaner inside the bowl and under the rim.\n2. Let it sit for 5–10 minutes.\n3. Scrub with a toilet brush.\n4. Flush and wipe the exterior with disinfectant.\n5. Dry with paper towels or a cleaning cloth."),
            .init(title: "Polish the mirror", details: "1. Spray glass cleaner or vinegar solution.\n2. Wipe with a microfiber cloth in S-shaped motions.\n3. Check for streaks and polish again if needed."),
            .init(title: "Change towels", details: "1. Remove used towels.\n2. Replace them with fresh, clean ones.\n3. Wash dirty towels with appropriate detergent.\n4. Fold and store when dry."),
            .init(title: "Scrub the shower", details: "1. Remove bottles and accessories.\n2. Spray an anti-lime or soap scum remover.\n3. Let it sit, then scrub tiles and glass.\n4. Rinse well and dry surfaces."),
            .init(title: "Empty the trash", details: "1. Remove the full trash bag.\n2. Wipe or rinse the bin if needed.\n3. Replace with a new liner."),
            .init(title: "Clean the floor", details: "1. Sweep or vacuum hair and dust.\n2. Mop with bathroom-safe cleaner.\n3. Let it dry before walking in."),
            .init(title: "Replace toiletries", details: "1. Check supplies like soap, shampoo, and toilet paper.\n2. Restock missing items.\n3. Keep products neatly organized."),
            .init(title: "Ventilate the room", details: "1. Open the window after each shower.\n2. Turn on the fan if available.\n3. Keep the door slightly open to allow airflow."),
            .init(title: "Clean the toothbrush holder", details: "1. Empty the holder.\n2. Wash it with soap and hot water.\n3. Dry completely before putting it back.")
        ]
    ),
    .init(
        name: "Bedroom",
        icon: "bed.double.fill",
        color: .purple,
        description: "Organize your room for a tidy and relaxing environment.",
        tips: [
            .init(title: "Make the bed", details: "1. Straighten the sheets and tuck corners.\n2. Spread the blanket evenly.\n3. Arrange pillows neatly.\n4. Add a final touch by folding the top edge."),
            .init(title: "Dust furniture", details: "1. Remove all items from surfaces.\n2. Wipe with a microfiber cloth.\n3. Dust under and behind objects.\n4. Put everything back neatly."),
            .init(title: "Vacuum the floor", details: "1. Clear clutter off the floor.\n2. Vacuum carpet and under the bed.\n3. Use small attachments for corners.\n4. Empty the canister when finished."),
            .init(title: "Change sheets", details: "1. Strip old sheets and pillowcases.\n2. Put on clean ones, pulling corners tightly.\n3. Wash the old set immediately."),
            .init(title: "Declutter surfaces", details: "1. Remove unnecessary items from nightstands and dressers.\n2. Separate things to keep, donate, or toss.\n3. Wipe down surfaces before reorganizing."),
            .init(title: "Organize wardrobe", details: "1. Take everything out.\n2. Sort by type or season.\n3. Fold or hang neatly.\n4. Donate clothes you no longer wear."),
            .init(title: "Air out the room", details: "1. Open windows every morning for 10 minutes.\n2. Let fresh air circulate.\n3. Close windows once the air feels renewed."),
            .init(title: "Clean mirrors", details: "1. Spray with glass cleaner.\n2. Wipe in circular motions using a microfiber cloth.\n3. Buff with a dry part for a streak-free shine."),
            .init(title: "Check lighting", details: "1. Make sure all bulbs work.\n2. Replace burnt ones.\n3. Dust lamp shades and light fixtures."),
            .init(title: "Add scent", details: "1. Choose a mild air freshener or candle.\n2. Place it safely away from flammable fabrics.\n3. Use sparingly for a pleasant aroma.")
        ]
    ),
    .init(
        name: "Living Room",
        icon: "sofa.fill",
        color: .brown,
        description: "Keep your living room clean and cozy.",
        tips: [
            .init(title: "Organize shelves", details: "1. Remove all items from the shelves.\n2. Wipe surfaces with a damp cloth.\n3. Return only essential decor.\n4. Leave open space for a tidy look."),
            .init(title: "Clean the coffee table", details: "1. Clear off all objects.\n2. Wipe with surface cleaner.\n3. Dry and restyle with only essentials."),
            .init(title: "Vacuum the carpet", details: "1. Move lightweight furniture.\n2. Vacuum thoroughly, including corners.\n3. Treat any stains with a cleaner."),
            .init(title: "Fluff pillows", details: "1. Remove pillows and shake them well.\n2. Fluff by hand to restore shape.\n3. Place them evenly on the couch."),
            .init(title: "Wipe electronics", details: "1. Turn off and unplug devices.\n2. Wipe with a soft, dry microfiber cloth.\n3. Clean screens and remotes gently."),
            .init(title: "Clean windows", details: "1. Open curtains and dust blinds.\n2. Spray glass cleaner on the window.\n3. Wipe top to bottom with a dry cloth."),
            .init(title: "Tidy cables", details: "1. Unplug and untangle wires.\n2. Group them using clips or ties.\n3. Label if necessary and hide behind furniture."),
            .init(title: "Mop the floor", details: "1. Sweep or vacuum first.\n2. Mop using a cleaner suitable for the floor type.\n3. Let dry completely."),
            .init(title: "Water plants", details: "1. Check soil moisture.\n2. Water only if dry.\n3. Remove dead leaves and dust off foliage."),
            .init(title: "Dust lamps", details: "1. Turn off and cool lamps.\n2. Wipe gently with a duster or cloth.\n3. Clean lampshades as needed.")
        ]
    ),
    .init(
        name: "Clothes",
        icon: "tshirt.fill",
        color: .pink,
        description: "Manage laundry and washing cycles.",
        tips: [
            .init(title: "Sort clothes", details: "1. Separate whites, colors, and delicates.\n2. Check pockets and close zippers.\n3. Pretreat stains before washing."),
            .init(title: "Start washing cycle", details: "1. Choose the correct cycle for the fabric.\n2. Add detergent and softener as needed.\n3. Start the machine and wait for the cycle to finish."),
            .init(title: "Fold laundry", details: "1. Remove clothes right after washing or drying.\n2. Fold neatly to avoid wrinkles.\n3. Store by category."),
            .init(title: "Iron shirts", details: "1. Set the iron to the right temperature.\n2. Iron inside out for delicate fabrics.\n3. Hang immediately after ironing."),
            .init(title: "Use fabric softener", details: "1. Add to the dedicated compartment.\n2. Follow the recommended amount.\n3. Avoid overuse to keep fabrics absorbent."),
            .init(title: "Clean lint filter", details: "1. Remove lint filter from dryer.\n2. Take off all lint by hand or brush.\n3. Wash and dry before reinserting."),
            .init(title: "Hang delicate items", details: "1. Take out delicate clothes after washing.\n2. Hang or lay flat to dry.\n3. Avoid direct sunlight."),
            .init(title: "Organize wardrobe", details: "1. Group clothes by color and type.\n2. Fold or hang neatly.\n3. Use dividers for accessories."),
            .init(title: "Donate old clothes", details: "1. Separate clothes you no longer wear.\n2. Wash and fold them.\n3. Bring them to a donation center."),
            .init(title: "Check labels", details: "1. Read the washing instructions.\n2. Follow temperature and drying recommendations.\n3. Adjust wash cycle accordingly.")
        ]
    ),
    .init(
        name: "Office",
        icon: "laptopcomputer",
        color: .teal,
        description: "Maintain a clean and productive workspace.",
        tips: [
            .init(title: "Organize the desk", details: "1. Remove everything from the desk.\n2. Keep only what you use daily.\n3. Store the rest in drawers or shelves."),
            .init(title: "Clean the monitor", details: "1. Turn off the screen and unplug it.\n2. Wipe with a dry microfiber cloth.\n3. Dampen lightly if needed and dry right away."),
            .init(title: "Empty the trash bin", details: "1. Empty the bin daily.\n2. Clean the inside if dirty.\n3. Replace with a new liner."),
            .init(title: "Arrange cables", details: "1. Disconnect and group similar cables.\n2. Tie them using clips or cable ties.\n3. Label for easy identification."),
            .init(title: "Wipe the keyboard", details: "1. Turn off or disconnect.\n2. Shake out crumbs and dust.\n3. Spray air between keys.\n4. Wipe with disinfectant cloth."),
            .init(title: "Sort documents", details: "1. Gather all papers.\n2. Separate by urgency or topic.\n3. File or discard unnecessary ones."),
            .init(title: "Declutter workspace", details: "1. Remove unused items.\n2. Keep only tools you need daily.\n3. Store the rest neatly."),
            .init(title: "Add greenery", details: "1. Choose an easy indoor plant.\n2. Place it where it gets light.\n3. Water weekly and trim dry leaves."),
            .init(title: "Adjust lighting", details: "1. Check that lighting isn’t too harsh.\n2. Add a desk lamp if needed.\n3. Adjust brightness for comfort."),
            .init(title: "Backup files", details: "1. Identify important folders.\n2. Save them to a cloud or external drive.\n3. Schedule regular backups.")
        ]
    ),
    .init(
        name: "Repair",
        icon: "wrench.and.screwdriver.fill",
        color: .yellow,
        description: "If something needs fixing, we've got you covered.",
        tips: [
            .init(title: "Replace lights", details: "1. Turn off the power.\n2. Let the bulb cool down.\n3. Remove and replace with a new one.\n4. Turn on to test."),
            .init(title: "Fix the sink", details: "1. Identify the leak.\n2. Tighten loose fittings.\n3. Replace worn washers or seals.\n4. Test for drips after turning the water back on."),
            .init(title: "Inspect tools", details: "1. Lay tools on a clean surface.\n2. Check for rust or loose parts.\n3. Oil metal pieces and tighten screws.\n4. Store in a dry box."),
            .init(title: "Check smoke alarms", details: "1. Press the test button.\n2. Replace batteries if weak.\n3. Clean dust around sensors.\n4. Test again."),
            .init(title: "Oil door hinges", details: "1. Apply a few drops of lubricant.\n2. Move the door to distribute oil.\n3. Wipe excess with a cloth."),
            .init(title: "Tighten screws", details: "1. Check furniture and fixtures.\n2. Tighten all loose screws.\n3. Replace damaged ones if needed."),
            .init(title: "Clean vents", details: "1. Remove vent covers.\n2. Vacuum dust inside.\n3. Wash covers with soap and dry before reattaching."),
            .init(title: "Repair walls", details: "1. Clean around the damaged area.\n2. Apply filler or spackle.\n3. Sand and repaint when dry."),
            .init(title: "Test outlets", details: "1. Plug in a small device.\n2. Watch for sparks or overheating.\n3. Unplug immediately if faulty and call an electrician."),
            .init(title: "Inspect plumbing", details: "1. Check under sinks for leaks.\n2. Look for damp spots or mold.\n3. Tighten or repair as needed.")
        ]
    ),
    .init(
        name: "Schedule",
        icon: "calendar",
        color: .green,
        description: "Manage your day effectively.",
        tips: [
            .init(title: "Plan the week", details: "1. Spend 15–30 minutes on Sunday planning.\n2. List your main goals for each day.\n3. Assign time and priority.\n4. Add reminders to your calendar."),
            .init(title: "Set reminders", details: "1. Choose your preferred reminder app.\n2. Schedule realistic times.\n3. Enable repeat for recurring tasks.\n4. Mark tasks complete as you finish them."),
            .init(title: "Review progress", details: "1. Check your list at the end of the day.\n2. Mark done items and move unfinished ones.\n3. Reflect on what can be improved."),
            .init(title: "Block time", details: "1. Divide your day into time blocks.\n2. Assign one task per block.\n3. Mute distractions.\n4. Take short breaks between blocks."),
            .init(title: "Start small", details: "1. Begin with quick, easy tasks.\n2. Complete one or two to build momentum.\n3. Gradually move to longer ones."),
            .init(title: "Avoid multitasking", details: "1. Focus on one task at a time.\n2. Use a timer for deep work.\n3. Finish before switching."),
            .init(title: "Use color coding", details: "1. Assign colors to task types.\n2. Use those colors in your planner or app.\n3. Recognize patterns and balance your workload."),
            .init(title: "Schedule breaks", details: "1. Include 5–10 minute breaks.\n2. Stretch, hydrate, or walk.\n3. Avoid screens to rest your eyes."),
            .init(title: "Set daily priorities", details: "1. Pick your top three goals.\n2. Tackle the hardest one first.\n3. Celebrate progress."),
            .init(title: "Reflect weekly", details: "1. Review what you accomplished.\n2. Identify what took too much time.\n3. Adjust your next week’s schedule.")
        ]
    )
]
