books.rb: Search books by different attributes
==============================================

První úkol do předmětu Ruby PV249.

Zadání
------

Vašim úkolem bude naspat script `books.rb`, který se bude chovat následovně:

1. načte informace o knihách, autorech, jazycích a vydavatelích ze souboru
   `books.csv`. Jednotlivé csv části jsou odděleny řetězcem `====== {název tabulky} ======`

2. skript dokáže filtrovat pomocí následujících atributů:

```
# vyhledej všechny knihy Karla Čapka
books.rb -a "Karel Čapek"

# vyhledej všechny knihy Karla Čapka v angličtině
books.rb -a "Karel Čapek" -l eng

# vyhledej všechy knihy Karla Čapka v angličtině ve vydavatelství Catbird Press
books.rb -a "Karel Čapek" -l eng -p "Catbird Press"
```

3. skript vypisuje knihy ve formátu "Autor1, Autor2 (rok): titul", příklad:

```
Guillaume Apollinaire, Karel Čapek, Adolf Kroupa, Milan Kundera (1965): Alkoholy života
Karel Čapek (1924): Anglické listy
Karel Čapek (1925): Anglické listy
```

Podmínky pro uznání řešení:
---------------------------

1. script bude pracovat podle zadání
2. příkaz `bundle exec rake` proběhne úspěšně.

`bundle exec rake` spustí kontroly pro úkol: rubocop a testy. Před prvním spuštěním nezapomeňte
na `bundle install`.
  * `bundle exec rake rubocop` spustí pouze rubocop
  * `bundle exec rake test` spustí pouze testy


Může se hodit
-------------

* [Dokumentace ke třídě String](https://ruby-doc.org/core-2.4.1/String.html)
* [Dokumentace ke třídě Array](https://ruby-doc.org/core-2.4.1/Array.html)
* [Dokumentace ke třídě Hash](https://ruby-doc.org/core-2.4.1/Hash.html)
* [Dokumentace k modulu Enumerable](https://ruby-doc.org/core-2.4.1/Enumerable.html)
* [Dokumentace ke třídě OptionParser](https://ruby-doc.org/stdlib-2.4.2/libdoc/optparse/rdoc/OptionParser.html)
* [Dokumentace ke knihovně CSV](http://ruby-doc.org/stdlib-2.4.1/libdoc/csv/rdoc/CSV.html)

Odevzdání
---------

* Do 10. 10. 2017 (včetně)
* Konzultace k úkolu na cvičení 2. 10. 2017
* Způsob odevzdání: bude upřesněn na přednášce 2. 10. 2017 věnované nástroji `git`

