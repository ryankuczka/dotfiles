package fzf

import "testing"

func TestParseRange(t *testing.T) {
	{
		i := ".."
		r, _ := ParseRange(&i)
		if r.begin != rangeEllipsis || r.end != rangeEllipsis {
			t.Errorf("%s", r)
		}
	}
	{
		i := "3.."
		r, _ := ParseRange(&i)
		if r.begin != 3 || r.end != rangeEllipsis {
			t.Errorf("%s", r)
		}
	}
	{
		i := "3..5"
		r, _ := ParseRange(&i)
		if r.begin != 3 || r.end != 5 {
			t.Errorf("%s", r)
		}
	}
	{
		i := "-3..-5"
		r, _ := ParseRange(&i)
		if r.begin != -3 || r.end != -5 {
			t.Errorf("%s", r)
		}
	}
	{
		i := "3"
		r, _ := ParseRange(&i)
		if r.begin != 3 || r.end != 3 {
			t.Errorf("%s", r)
		}
	}
}

func TestTokenize(t *testing.T) {
	// AWK-style
	input := "  abc:  def:  ghi  "
	tokens := Tokenize(&input, nil)
	if string(*tokens[0].text) != "abc:  " || tokens[0].prefixLength != 2 {
		t.Errorf("%s", tokens)
	}

	// With delimiter
	tokens = Tokenize(&input, delimiterRegexp(":"))
	if string(*tokens[0].text) != "  abc:" || tokens[0].prefixLength != 0 {
		t.Errorf("%s", tokens)
	}
}

func TestTransform(t *testing.T) {
	input := "  abc:  def:  ghi:  jkl"
	{
		tokens := Tokenize(&input, nil)
		{
			ranges := splitNth("1,2,3")
			tx := Transform(tokens, ranges)
			if *joinTokens(tx) != "abc:  def:  ghi:  " {
				t.Errorf("%s", *tx)
			}
		}
		{
			ranges := splitNth("1..2,3,2..,1")
			tx := Transform(tokens, ranges)
			if *joinTokens(tx) != "abc:  def:  ghi:  def:  ghi:  jklabc:  " ||
				len(*tx) != 4 ||
				string(*(*tx)[0].text) != "abc:  def:  " || (*tx)[0].prefixLength != 2 ||
				string(*(*tx)[1].text) != "ghi:  " || (*tx)[1].prefixLength != 14 ||
				string(*(*tx)[2].text) != "def:  ghi:  jkl" || (*tx)[2].prefixLength != 8 ||
				string(*(*tx)[3].text) != "abc:  " || (*tx)[3].prefixLength != 2 {
				t.Errorf("%s", *tx)
			}
		}
	}
	{
		tokens := Tokenize(&input, delimiterRegexp(":"))
		{
			ranges := splitNth("1..2,3,2..,1")
			tx := Transform(tokens, ranges)
			if *joinTokens(tx) != "  abc:  def:  ghi:  def:  ghi:  jkl  abc:" ||
				len(*tx) != 4 ||
				string(*(*tx)[0].text) != "  abc:  def:" || (*tx)[0].prefixLength != 0 ||
				string(*(*tx)[1].text) != "  ghi:" || (*tx)[1].prefixLength != 12 ||
				string(*(*tx)[2].text) != "  def:  ghi:  jkl" || (*tx)[2].prefixLength != 6 ||
				string(*(*tx)[3].text) != "  abc:" || (*tx)[3].prefixLength != 0 {
				t.Errorf("%s", *tx)
			}
		}
	}
}

func TestTransformIndexOutOfBounds(t *testing.T) {
	Transform([]Token{}, splitNth("1"))
}
