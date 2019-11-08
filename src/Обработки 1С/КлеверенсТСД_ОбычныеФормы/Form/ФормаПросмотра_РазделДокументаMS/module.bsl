﻿
Процедура СкрытьПустыеПриИзменении(Элемент)	
	ЗаполнитьТаблицу();		
КонецПроцедуры

Процедура ПриОткрытии()
	Заголовок = "Клеверенс: " = ДанныеЗаголовка;
	ЗаполнитьТаблицу();
КонецПроцедуры

Процедура ЗаполнитьТаблицу()
	
	ТаблицаРеквизитов.Очистить();
	Если ТипЗнч(ДанныеДляПоказа) = Тип("Структура") Тогда
		Для Каждого РеквизитШапки Из ДанныеДляПоказа Цикл
			Если СкрытьПустые И НЕ ЗначениеЗаполнено(РеквизитШапки.Значение) Тогда
				Продолжить;
			КонецЕсли;
			НоваяСтрока = ТаблицаРеквизитов.Добавить();
			НоваяСтрока.ИмяРеквизита = РеквизитШапки.Ключ;
			НоваяСтрока.ЗначениеРеквизита = РеквизитШапки.Значение;
		КонецЦикла;
	ИначеЕсли ТипЗнч(ДанныеДляПоказа) = Тип("СтрокаТаблицыЗначений") Тогда
		
		Для Каждого Колонка Из ДанныеДляПоказа.Владелец().Колонки Цикл
			Если СкрытьПустые И НЕ ЗначениеЗаполнено(ДанныеДляПоказа[Колонка.Имя]) Тогда
				Продолжить;
			КонецЕсли;
			НоваяСтрока = ТаблицаРеквизитов.Добавить();
			НоваяСтрока.ИмяРеквизита = Колонка.Имя;
			НоваяСтрока.ЗначениеРеквизита = ДанныеДляПоказа[Колонка.Имя];
		КонецЦикла;
	КонецЕсли;
	
	ТаблицаРеквизитов.Сортировать("ИмяРеквизита");
	
КонецПроцедуры