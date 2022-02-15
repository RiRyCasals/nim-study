import complex

let myComplex = complex[float64](10.0, 0.0)
echo myComplex.type
echo myComplex

echo im(2.5)
echo im(float64)


let
  c1 = complex[float64](10.0, 2.0)
  c2 = complex[float64](5.0, 20.0)
  c3 = im(2.0)

echo c1 + c2
echo c1 - c2
echo c1 * c2
echo c1 / c2
echo c1 + c3
