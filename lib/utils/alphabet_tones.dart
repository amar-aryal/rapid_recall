// for vowels, the initial pinyin letter could have any tone
// so, while filtering, comparison needs to take into account multiple forms

RegExp vowelsRegexGenerator(String vowel) {
  if (vowel == 'a') {
    return RegExp(r'^[aāáǎà]');
  } else if (vowel == 'e') {
    return RegExp(r'^[eēéěè]');
  } else if (vowel == 'i') {
    return RegExp(r'^[iīíǐì]');
  } else if (vowel == 'o') {
    return RegExp(r'^[oōóǒò]');
  } else {
    return RegExp(r'^[uūúǔùǖǘǚǜ]');
  }
}
