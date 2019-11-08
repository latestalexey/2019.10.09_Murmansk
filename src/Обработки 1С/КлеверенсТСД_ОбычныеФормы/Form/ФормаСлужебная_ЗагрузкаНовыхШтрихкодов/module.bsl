﻿Перем ЗаписаныНовыеШтрихкоды;
Перем СтруктураХраненияШК;

Процедура ПриОткрытии()
	
	//создать колонки табличной части в соответствии с данными объекта, в котором хранятся штрихкоды.
 	ТаблицаНовыеШтрихкоды = Новый ТаблицаЗначений;
	ТаблицаНовыеШтрихкоды.Колонки.Добавить("НомерСтроки",Новый  ОписаниеТипов("Число"),"N");
	ТаблицаНовыеШтрихкоды.Колонки.Добавить("Изменить",Новый  ОписаниеТипов("Булево"));

	МетаданныеНСИ = _ЛокКонтекст.ЛокЯдро_ПолучитьМетаданныеНСИ();
	
	СтруктураХраненияШК = Новый Структура;
	СтруктураХраненияШК.Вставить("ШК_ОбъектМетаданных", 		МетаданныеНСИ.Штрихкоды.Путь_ОбъектМетаданных);
	СтруктураХраненияШК.Вставить("ШК_ИзмерениеНоменклатуры", 	МетаданныеНСИ.Штрихкоды.Реквизиты.Номенклатура);
	СтруктураХраненияШК.Вставить("ШК_ИзмерениеУпаковки", 		МетаданныеНСИ.Штрихкоды.Реквизиты.ЕдиницаИзмерения);
	СтруктураХраненияШК.Вставить("ШК_ИзмерениеШтрихкода", 		МетаданныеНСИ.Штрихкоды.Реквизиты.Штрихкод);
	
	Если Найти(МетаданныеНСИ.Штрихкоды.Путь_ОбъектМетаданных, "РегистрСведений") Тогда
	 	ОбработатьКоллекциюМетаданныхОбъекта(ТаблицаНовыеШтрихкоды, МетаданныеНСИ.Штрихкоды.Путь_ОбъектМетаданных + ".Измерения");
		ОбработатьКоллекциюМетаданныхОбъекта(ТаблицаНовыеШтрихкоды, МетаданныеНСИ.Штрихкоды.Путь_ОбъектМетаданных + ".Ресурсы");
		ОбработатьКоллекциюМетаданныхОбъекта(ТаблицаНовыеШтрихкоды, МетаданныеНСИ.Штрихкоды.Путь_ОбъектМетаданных + ".Реквизиты");
	Иначе
		ОбработатьКоллекциюМетаданныхОбъекта(ТаблицаНовыеШтрихкоды, МетаданныеНСИ.Штрихкоды.Путь_ОбъектМетаданных + ".Реквизиты");
	КонецЕсли;		
	
	// колонку "ИмяНеизвестного" нужно расположить справа от колонки "Номенклатура"
	КолонкаНоменклатура = ТаблицаНовыеШтрихкоды.Колонки.Найти(МетаданныеНСИ.Штрихкоды.Реквизиты.Номенклатура);
	
	Если КолонкаНоменклатура <> Неопределено Тогда
		ИндексКолонкиНоменклатура = ТаблицаНовыеШтрихкоды.Колонки.Индекс(КолонкаНоменклатура);
	Иначе	
		ИндексКолонкиНоменклатура = 3;
	КонецЕсли;		
	
	ТаблицаНовыеШтрихкоды.Колонки.Вставить(ИндексКолонкиНоменклатура + 1, "ИмяНеизвестного",Новый  ОписаниеТипов("Строка"), "Имя неизвестного");
	
	ЭлементыФормы.ТаблицаНовыеШтрихкоды.Значение = ТаблицаНовыеШтрихкоды;
	ЭлементыФормы.ТаблицаНовыеШтрихкоды.СоздатьКолонки();
	
	Для каждого Колонка из ТаблицаНовыеШтрихкоды.Колонки Цикл
		КолонкаТЧ =  ЭлементыФормы.ТаблицаНовыеШтрихкоды.Колонки[Колонка.Имя];
		ЭлементУправленияТЧ = КолонкаТЧ.ЭлементУправления;
		ЭлементУправленияТЧ.УстановитьДействие("НачалоВыбора",Новый Действие("ДействиеНачалоВыбораЗначения"));
		ЭлементУправленияТЧ.УстановитьДействие("ПриИзменении",Новый Действие("ДействиеПриИзмененииЗначения"));
		ЭлементУправленияТЧ.АвтоОтметкаНезаполненного = Истина;
		ЭлементУправленияТЧ.ОтметкаНезаполненного     = Истина;
		КолонкаТЧ.Ширина  = 15;
	КонецЦикла;
	
	КолонкаФлагВыбора = ЭлементыФормы.ТаблицаНовыеШтрихкоды.Колонки.Найти("Изменить");
	КолонкаФлагВыбора.РежимРедактирования = РежимРедактированияКолонки.Непосредственно;  
	КолонкаФлагВыбора.УстановитьЭлементУправления(Тип("Флажок"));
	КолонкаФлагВыбора.ДанныеФлажка     = "Изменить";
	КолонкаФлагВыбора.Данные           = "";
	КолонкаФлагВыбора.ТекстШапки       = "Записывать";
	КолонкаФлагВыбора.Ширина           = 10;
	КолонкаФлагВыбора.ЭлементУправления.ГоризонтальноеПоложение = ГоризонтальноеПоложение.Центр;
	КолонкаФлагВыбора.ИзменениеРазмера = ИзменениеРазмераКолонки.НеИзменять;
	
	КолонкаНомерСтроки = ЭлементыФормы.ТаблицаНовыеШтрихкоды.Колонки.Найти("НомерСтроки");
	КолонкаНомерСтроки.Ширина           = 3;
    КолонкаНомерСтроки.ТолькоПросмотр   = Истина;
 	КолонкаНомерСтроки.ИзменениеРазмера = ИзменениеРазмераКолонки.НеИзменять;
	
	КолонкаШтрихкод = ЭлементыФормы.ТаблицаНовыеШтрихкоды.Колонки.Найти(МетаданныеНСИ.Штрихкоды.Реквизиты.Штрихкод);
	КолонкаШтрихкод.Ширина           = 13;
    КолонкаШтрихкод.ТолькоПросмотр   = Истина;
  	КолонкаШтрихкод.ИзменениеРазмера = ИзменениеРазмераКолонки.НеИзменять;

	КолонкаНоменклатура = ЭлементыФормы.ТаблицаНовыеШтрихкоды.Колонки[МетаданныеНСИ.Штрихкоды.Реквизиты.Номенклатура]; 
	КолонкаНоменклатура.ЭлементУправления.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка." + МетаданныеНСИ.Номенклатура.ИмяСправочника); 
	КолонкаНоменклатура.ЭлементУправления.Значение = КолонкаНоменклатура.ЭлементУправления.ОграничениеТипа.ПривестиЗначение(КолонкаНоменклатура.ЭлементУправления.Значение);

	//обработка полученной таблицы штрихкодов с MobileSMARTS в соответствии с объектом 1С где хранятся штрихкоды.Начало.
	ВладелецФормы.ТаблицаНовыхШтрихкодов.Свернуть("Записывать,Номенклатура,ТипШтрихКода,Упаковка,Характеристика,ШтрихКод,ИмяНеизвестного");
	Для каждого СтрокаТЧ из ВладелецФормы.ТаблицаНовыхШтрихкодов Цикл
		Если _ЛокКонтекст.ЛокЯдро_ШтрихКодЕстьВБазе1С(СтрокаТЧ.ШтрихКод, СтруктураХраненияШК) Тогда
			Продолжить
		КонецЕсли;
		
		НоваяСтрока =  ТаблицаНовыеШтрихкоды.Добавить();
		НоваяСтрока.НомерСтроки = ТаблицаНовыеШтрихкоды.Индекс(НоваяСтрока)+1;
		НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.Штрихкод] = СтрокаТЧ.ШтрихКод;
		НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.Номенклатура] = Справочники[МетаданныеНСИ.Номенклатура.ИмяСправочника].ПустаяСсылка();
		Попытка
		Если ЗначениеЗаполнено(СтрокаТЧ.НаименованиеТовара) или  ЗначениеЗаполнено(СтрокаТЧ.КодТовара)Тогда
			Номенклатура = Справочники[МетаданныеНСИ.Номенклатура.ИмяСправочника].НайтиПоКоду(СтрокаТЧ.КодТовара);
			Если НЕ ЗначениеЗаполнено(Номенклатура) Тогда
				Номенклатура = Справочники[МетаданныеНСИ.Номенклатура.ИмяСправочника].НайтиПоНаименованию(СтрокаТЧ.НаименованиеТовара,истина);
			КонецЕсли;
			Если НЕ ЗначениеЗаполнено(Номенклатура) Тогда
				Продолжить;
			КонецЕсли;	
			
			НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.Номенклатура]   = Номенклатура;
			НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.Характеристика] = Справочники[МетаданныеНСИ.Характеристики.ИмяСправочника].НайтиПоНаименованию(СтрокаТЧ.Характеристика,Истина,,Номенклатура);
			
			ЕдИзм = Справочники.ЕдиницыИзмерения.НайтиПоКоду(СтрокаТЧ.НаименованиеУпаковки,,,Номенклатура);
			Если НЕ ЗначениеЗаполнено(ЕдИзм) Тогда
				Попытка
					ЕдИзм = Справочники[МетаданныеНСИ.ЕдиницыИзмерения.ИмяСправочника].НайтиПоНаименованию(СтрокаТЧ.НаименованиеУпаковки,,,Номенклатура);
				Исключение
				КонецПопытки;
			КонецЕсли;
			Если ЗначениеЗаполнено(ЕдИзм) Тогда
				НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.ЕдиницаИзмерения] = ЕдИзм;
			КонецЕсли;
		КонецЕсли;
		Исключение
		
		КонецПопытки;

		Если ЗначениеЗаполнено(СтрокаТЧ.Номенклатура) Тогда
			НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.Номенклатура] = СтрокаТЧ.Номенклатура;	
		КонецЕсли;
		
		Если ЗначениеЗаполнено(СтрокаТЧ.Номенклатура) Тогда
			НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.ЕдиницаИзмерения] = СтрокаТЧ.Упаковка;	
		КонецЕсли;
		
		Если ЗначениеЗаполнено(СтрокаТЧ.Характеристика) Тогда
			НоваяСтрока[МетаданныеНСИ.Штрихкоды.Реквизиты.Характеристика] = СтрокаТЧ.Характеристика;	
		КонецЕсли;
		
		НоваяСтрока.ИмяНеизвестного = СтрокаТЧ.ИмяНеизвестного;
		
		ЗаполнитьЗначенияПоУмолчанию(НоваяСтрока);		
	КонецЦикла;
	//обработка полученной таблицы штрихкодов с MobileSMARTS в соответствии с объектом 1С где хранятся штрихкоды.Окончание.
 
КонецПроцедуры

Процедура ЗаполнитьЗначенияПоУмолчанию(НоваяСтрока)	
	
	ПрефиксКонфигурации = ГлЯдро_ПолучитьПрефиксКонфигурации();
	
	Попытка
		Если ПрефиксКонфигурации = "ДалионУМ" Тогда
			Выполнить("НоваяСтрока.ТипШтрихкода = ОпределениеТипаШтрихКода(НоваяСтрока.Штрихкод)");
		ИначеЕсли ПрефиксКонфигурации = "ШтрихМ" Тогда
			НоваяСтрока.Единица = НоваяСтрока.Владелец.БазоваяЕдиница; 
		ИначеЕсли ПрефиксКонфигурации = "УТ_10_3" Тогда
			НоваяСтрока.Качество      = Справочники.Качество.Новый;
			НоваяСтрока.ТипШтрихкода  = ПланыВидовХарактеристик.ТипыШтрихкодов.EAN13;
		КонецЕсли;  
	Исключение
	КонецПопытки;
	
КонецПроцедуры

Процедура ОбработатьКоллекциюМетаданныхОбъекта(ТаблицаНовыеШтрихкоды,Знач КоллекцияМетаданныхОбъектаИмя)
	
	КоллекцияМетаданныхОбъекта = "";
	КоллекцияМетаданныхОбъектаИмя = СтрЗаменить(КоллекцияМетаданныхОбъектаИмя,"РегистрСведений","РегистрыСведений");
	КоллекцияМетаданныхОбъектаИмя = СтрЗаменить(КоллекцияМетаданныхОбъектаИмя,"Справочник","Справочники");
	
	Выполнить("КоллекцияМетаданныхОбъекта = Метаданные."+КоллекцияМетаданныхОбъектаИмя);
	Если Найти(КоллекцияМетаданныхОбъектаИмя, "Справочник") Тогда
		ЕстьКолонкаНоменклатура = Ложь;
		ЕстьКолонкаШтрихКод     = Ложь;
		Для каждого КолонкаТаблицы из ТаблицаНовыеШтрихкоды Цикл
			Если  КолонкаТаблицы.Синоним = "Номенклатура" Тогда
				ЕстьКолонкаНоменклатура = Истина;
			КонецЕсли;
			Если  КолонкаТаблицы.Синоним = "Штрихкод" Тогда
				ЕстьКолонкаШтрихКод = Истина;
			КонецЕсли;
		КонецЦикла;
		
		Если не ЕстьКолонкаНоменклатура Тогда
			ТаблицаНовыеШтрихкоды.Колонки.Добавить(СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры,Новый ОписаниеТипов("СправочникСсылка.номенклатура"),"Номенклатура");
		КонецЕсли;		
		Если не ЕстьКолонкаШтрихКод Тогда
			ТаблицаНовыеШтрихкоды.Колонки.Добавить(СтруктураХраненияШК.ШК_ИзмерениеШтрихкода,Новый ОписаниеТипов("Строка"),"Штрихкод");
		КонецЕсли;
	КонецЕсли;

	ТипНоменклатура = Тип("СправочникСсылка.Номенклатура");
	
	Для каждого ЭлементКоллекции из КоллекцияМетаданныхОбъекта Цикл
		Если Найти(ЭлементКоллекции.имя,"Удалить") = 0 Тогда
			НазваниеКолонкиНоменклатура = ?(ЭлементКоллекции.тип.СодержитТип(ТипНоменклатура),"Номенклатура", ЭлементКоллекции.Синоним);
			ТаблицаНовыеШтрихкоды.Колонки.Добавить(ЭлементКоллекции.имя,ЭлементКоллекции.Тип,НазваниеКолонкиНоменклатура);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ДействиеПриИзмененииЗначения(Элемент)
	
	//если номенклатура перевыбрана, проверить соответствие всех значений колонок, выбранных ранее
	Если ТипЗнч(Элемент.Значение) = Тип("СправочникСсылка.Номенклатура") Тогда
		Если Элемент.Значение.ЭтоГруппа Тогда
			Элемент.Значение = Справочники.Номенклатура.ПустаяСсылка();
		КонецЕсли;

		//Для каждого КолонкаТч из ТаблицаНовыеШтрихкоды.Колонки Цикл
		//	ИмяКолонки = нрег(КолонкаТч.Имя);
		//	Если не (ИмяКолонки = нрег(СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры)
		//		или ИмяКолонки = нрег(СтруктураХраненияШК.ШК_ИзмерениеШтрихкода) 
		//		или Найти("изменить,номерстроки",НРег(ИмяКолонки))>0) Тогда
		//		ЭлементыФормы.ТаблицаНовыеШтрихкоды.ТекущаяСтрока[КолонкаТч.Имя] = Неопределено;
		//	КонецЕсли;
		//КонецЦикла;
		ТекущаяСтрока = ЭлементыФормы.ТаблицаНовыеШтрихкоды.ТекущаяСтрока;
		
		ЗаполнитьЗначенияПоУмолчанию(ТекущаяСтрока);
		  
		РезультатПоиска = _ЛокКонтекст.ЛокЯдро_ПолучитьЕдиницуИзмеренияПоУмолчанию(ТекущаяСтрока[СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры]);

		Если ЗначениеЗаполнено(РезультатПоиска) Тогда            
			
			ТекущаяСтрока[СтруктураХраненияШК.ШК_ИзмерениеУпаковки] = РезультатПоиска.ЕдиницаИзмерения;
			
		КонецЕсли;
			
	КонецЕсли;
	
КонецПроцедуры
 
Процедура ДействиеНачалоВыбораЗначения(Элемент,СтандартнаяОбработка)
	
	//получить владельцев
	попытка
		ВладельцыОбъекта = Элемент.Значение.Метаданные().Владельцы;
		Если ВладельцыОбъекта.Количество() > 0 Тогда
			СтандартнаяОбработка  = Ложь;
		КонецЕсли;
	Исключение
 	КонецПопытки;
	
	//отбор в поле по владельцу
	Если НЕ СтандартнаяОбработка Тогда
		Попытка
			ИзмерениеНоменклатуры = СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры;
			Номенклатура = ЭлементыФормы.ТаблицаНовыеШтрихкоды.ТекущаяСтрока[ИзмерениеНоменклатуры];
			Если ЗначениеЗаполнено(Номенклатура) Тогда
				ФормаВыбора = Справочники[Элемент.Значение.метаданные().имя].ПолучитьФормуВыбора();
 				ФормаВыбора.ПараметрВыборПоВладельцу = Номенклатура;
				ФормаВыбора.ПараметрОтборПоВладельцу = Номенклатура;  
				Элемент.Значение = ФормаВыбора.ОткрытьМодально();
			Иначе
				Предупреждение("Не выбрана номенклатура!",10,"Изменение данных");
			КонецЕсли;
		Исключение
			Сообщить(ОписаниеОшибки());
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры


Процедура ОсновныеДействияФормыЗаписатьШтрихкоды(Кнопка)
	
	Отказ = Ложь;
	
	ДобавленныеШК = Новый СписокЗначений;
	
	ОбъектХраненияРегистрСведений = Найти(СтруктураХраненияШК.ШК_ОбъектМетаданных,"РегистрСведений")>0;
	
	РегистрСведенийИмя = СтруктураХраненияШК.ШК_ОбъектМетаданных;
	РегистрСведенийИмя = СтрЗаменить(РегистрСведенийИмя,"РегистрСведений.","");
	
	Для каждого СтрокаТЧ из ТаблицаНовыеШтрихкоды Цикл
		Если Не СтрокаТЧ.Изменить Тогда
			Продолжить;
		КонецЕсли;
		
		//проверить заполненность колонок строки.Начало.
		//все отображаемые колонки должны быть заполнены.
		ДанныеКолонокНеЗаполнены = ложь;
		Для каждого КолонкаТЧ из ТаблицаНовыеШтрихкоды.Колонки Цикл
			КолонкаТЧИмя = Нрег(КолонкаТЧ.имя);
 			Если Найти("изменить,номерстроки",НРег(КолонкаТЧИмя))>0 Тогда
				Продолжить
			КонецЕсли;
			
			Если ОбъектХраненияРегистрСведений Тогда
				ИзмерениеРегистра = Метаданные.РегистрыСведений[РегистрСведенийИмя].Измерения.Найти(КолонкаТЧИмя); 
				Если (ИзмерениеРегистра <> Неопределено и ИзмерениеРегистра.ЗапрещатьНезаполненныеЗначения) 
					или КолонкаТЧИмя = нрег(СтруктураХраненияШК.ШК_ИзмерениеШтрихкода)
					или КолонкаТЧИмя = "качество" 
					или КолонкаТЧИмя = Нрег(СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры) Тогда
					Если не ЗначениеЗаполнено(СтрокаТЧ[КолонкаТЧИмя]) Тогда
						ДанныеКолонокНеЗаполнены = Истина;
						Сообщить("В строке №"+Формат(СтрокаТЧ.НомерСтроки,"ЧГ=")+" не задано значение в колонке """ +КолонкаТЧ.Заголовок+"""",СтатусСообщения.Важное);
					КонецЕсли;
				КонецЕсли;
			Иначе
				Если КолонкаТЧИмя = Нрег(СтруктураХраненияШК.ШК_ИзмерениеШтрихкода)
					или КолонкаТЧИмя = Нрег(СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры)
					или КолонкаТЧИмя = Нрег(СтруктураХраненияШК.ШК_ИзмерениеУпаковки) тогда
					  Если не ЗначениеЗаполнено(СтрокаТЧ[КолонкаТЧИмя]) Тогда
						ДанныеКолонокНеЗаполнены = Истина;
						Сообщить("В строке №"+Формат(СтрокаТЧ.НомерСтроки,"ЧГ=")+" не задано значение в колонке """ +КолонкаТЧ.Заголовок+"""",СтатусСообщения.Важное);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;			
		КонецЦикла;
		
		Если ДанныеКолонокНеЗаполнены Тогда
			Отказ = Истина;
			Продолжить
		КонецЕсли;
		//проверить заполненность колонок строки.Окончание.
		
		Штрихкод =  СтрокаТЧ[СтруктураХраненияШК.ШК_ИзмерениеШтрихкода];

		//проверка существования штрихкода в базе.Начало.
		Если _ЛокКонтекст.ЛокЯдро_ШтрихКодЕстьВБазе1С(Штрихкод, СтруктураХраненияШК) Тогда
			ДобавленныеШК.Добавить(Штрихкод);
			Продолжить
		КонецЕсли;
		//проверка существования штрихкода в базе.Окончание.
		
		Запись = "";
		РегистрСведенийМенеджер = СтруктураХраненияШК.ШК_ОбъектМетаданных;
		РегистрСведенийМенеджер = СтрЗаменить(РегистрСведенийМенеджер,"РегистрСведений.","РегистрыСведений.");
		РегистрСведенийМенеджер = СтрЗаменить(РегистрСведенийМенеджер,"Справочник.","Справочники.");
		Выполнить("Запись = "+РегистрСведенийМенеджер+"."
		+?(Найти(РегистрСведенийМенеджер,"Справочник")>0,"СоздатьЭлемент()","СоздатьМенеджерЗаписи()"));
		ЗаполнитьЗначенияСвойств(Запись,СтрокаТЧ);
		Попытка
			Запись.Записать();
			Сообщить("Добавлен штрихкод """+Штрихкод+""" для номенклатуры """+СокрЛП(Запись[СтруктураХраненияШК.ШК_ИзмерениеНоменклатуры])+"""",СтатусСообщения.Информация);
			ДобавленныеШК.Добавить(Штрихкод);
			ЗаписаныНовыеШтрихкоды = Истина;
		Исключение
			ТекстОшибки = ОписаниеОшибки();
			Сообщить(ТекстОшибки, СтатусСообщения.Важное);
			Предупреждение(ТекстОшибки);	
		КонецПопытки;
	КонецЦикла;
	
	ЕстьДобавленныеШтрихкоды = Ложь;
	Если ДобавленныеШК.Количество()>0 Тогда   //если штрихкоды добавлены в 1с, удалить их с терминала
		ЕстьДобавленныеШтрихкоды = Истина;
		сч = 0;
		Пока сч < ТаблицаНовыеШтрихкоды.Количество()  Цикл
			Если ДобавленныеШК.НайтиПоЗначению(ТаблицаНовыеШтрихкоды[сч][СтруктураХраненияШК.ШК_ИзмерениеШтрихкода]) <> Неопределено Тогда
				ТаблицаНовыеШтрихкоды.Удалить(сч);
			Иначе
				сч = сч + 1;
			КонецЕсли
		КонецЦикла;      
		
		сч = 0;
		Пока сч < ВладелецФормы.ТаблицаНовыхШтрихкодов.Количество()  Цикл
			Если ДобавленныеШК.НайтиПоЗначению(ВладелецФормы.ТаблицаНовыхШтрихкодов[сч]["Штрихкод"]) <> Неопределено Тогда
				ВладелецФормы.ТаблицаНовыхШтрихкодов.Удалить(сч);
			Иначе
				сч = сч + 1;
			КонецЕсли
		КонецЦикла;   
	КонецЕсли; 
	
	Если Отказ тогда
		Предупреждение("Возникли ошибки при добавлении новых штрихкодов! Не все выбранные для добавления штрихкоды были записаны в базу! Подробное описание ошибки смотрите в окне сообщений!",20,"Изменение данных");
	Иначе
		Если ЕстьДобавленныеШтрихкоды Тогда
			Предупреждение("Штрихкоды успешно добавлены! Список добавленных штрихкодов приведен в окне сообщений!",20,"Изменение данных");
		КонецЕсли;
	КонецЕсли;
	
	Если ТаблицаНовыеШтрихкоды.Количество() = 0 Тогда
		Закрыть()
	КонецЕсли;
	
КонецПроцедуры
 
Процедура КоманднаяПанельТаблицыШтрхкодыОчиститьВыделение(Кнопка)
	
	ТаблицаНовыеШтрихкоды.ЗаполнитьЗначения(Ложь,"Изменить");
	
КонецПроцедуры

Процедура КоманднаяПанельТаблицыШтрхкодыВыделитьВсе(Кнопка)
	
	ТаблицаНовыеШтрихкоды.ЗаполнитьЗначения(Истина,"Изменить");

КонецПроцедуры

Процедура ПередОткрытием(Отказ, СтандартнаяОбработка)
	
	Если ВладелецФормы.ТаблицаНовыхШтрихкодов.Количество() = 0 Тогда
		//ТзНовыйШтрихкоды = 
		//Попытка
		//	
		//Исключение
		Отказ = истина;
		Предупреждение("Нет новых штрихкодов для добавления!",20);
		//КонецПопытки
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриЗакрытии()
	
	Если ЗаписаныНовыеШтрихкоды 
		//и Вопрос("Перезаполнить таблицу товаров полученных из ТСД?", РежимДиалогаВопрос.ДаНет, 0,,"Изменение данных") = КодВозвратаДиалога.Да 
		Тогда			
		//ВладелецФормы.ЗагрузитьДанныеНажатие(Неопределено,Ложь);
	КонецЕсли;
	
КонецПроцедуры

Процедура ТаблицаНовыеШтрихкодыПередНачаломДобавления(Элемент, Отказ, Копирование)
	
	Отказ = истина;
	
КонецПроцедуры

ЗаписаныНовыеШтрихкоды = Ложь;
