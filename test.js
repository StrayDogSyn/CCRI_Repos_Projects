let smashSentence = {
    subject: "I",
    verb: "smash",
    object: "the patriarchy",
    preposition: "against",
    article: "the",
    adverb: "fiercely",
    conjunction: "and",
    additionalAction: "shatter"
}
let { subject, verb, object, preposition, article, adverb, conjunction, additionalAction } = smashSentence;
console.log(`${subject} ${adverb} ${verb} ${article} ${object} ${preposition} ${article} ${additionalAction}.`);
// concatenation of smashSentence the hard way
let sentence = subject + " " + adverb + " " + verb + " " + article + " " + object + " " + preposition + " " + article + " " + additionalAction + ".";
console.log(sentence.trimEnd().trimStart());