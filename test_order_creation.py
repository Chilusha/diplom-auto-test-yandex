# Алина Махмутова, 44-я когорта — Финальный проект. Инженер по тестированию плюс

import requests
from config import BASE_URL, ORDERS_ENDPOINT, ORDER_TRACK_ENDPOINT
from data import get_order_data

class TestOrderCreation:

    def test_create_order_and_get_by_track(self):
        # Шаг 1: Создать заказ
        url_create = f"{BASE_URL}{ORDERS_ENDPOINT}"
        payload = get_order_data()
        response_create = requests.post(url_create, json=payload)
        
        # Проверяем, что заказ создан
        assert response_create.status_code == 201, f"Ошибка создания заказа: {response_create.status_code}"
        
        # Шаг 2: Сохранить трек заказа
        response_json = response_create.json()
        track = response_json.get("track")
        assert track is not None, "Трек не найден в ответе"
        print(f"✅ Заказ создан, трек: {track}")
        
        # Шаг 3: Получить заказ по треку
        url_get = f"{BASE_URL}{ORDER_TRACK_ENDPOINT}?t={track}"
        response_get = requests.get(url_get)
        
        # Шаг 4: Проверить, что код ответа 200
        assert response_get.status_code == 200, f"Ошибка получения заказа: {response_get.status_code}"
        print("✅ Заказ получен по треку, код 200")